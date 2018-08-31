module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Data.Session exposing (Session)
import Html.Styled as Html exposing (..)
import Page.Counter as Counter
import Page.Home as Home
import Route exposing (Route)
import Url exposing (Url)
import Views.Page as Page


type alias Flags =
    {}


type Page
    = Blank
    | HomePage Home.Model
    | CounterPage Counter.Model
    | NotFound


type alias Model =
    { navKey : Nav.Key
    , page : Page
    , session : Session
    }


type Msg
    = HomeMsg Home.Msg
    | CounterMsg Counter.Msg
    | RouteChanged (Maybe Route)
    | UrlChanged Url
    | UrlRequested Browser.UrlRequest


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    let
        toPage page subInit subMsg =
            let
                ( subModel, subCmds ) =
                    subInit model.session
            in
            ( { model | page = page subModel }
            , Cmd.map subMsg subCmds
            )
    in
    case maybeRoute of
        Nothing ->
            ( { model | page = NotFound }
            , Cmd.none
            )

        Just Route.Home ->
            toPage HomePage Home.init HomeMsg

        Just Route.Counter ->
            toPage CounterPage Counter.init CounterMsg


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    let
        -- you'll usually want to retrieve and decode serialized session
        -- information from flags here
        session =
            {}
    in
    setRoute (Route.fromUrl url)
        { navKey = navKey
        , page = Blank
        , session = session
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ page, session } as model) =
    let
        toPage toModel toMsg subUpdate subMsg subModel =
            let
                ( newModel, newCmd ) =
                    subUpdate subMsg subModel
            in
            ( { model | page = toModel newModel }
            , Cmd.map toMsg newCmd
            )
    in
    case ( msg, page ) of
        ( HomeMsg homeMsg, HomePage homeModel ) ->
            toPage HomePage HomeMsg (Home.update session) homeMsg homeModel

        ( CounterMsg counterMsg, CounterPage counterModel ) ->
            toPage CounterPage CounterMsg (Counter.update session) counterMsg counterModel

        ( RouteChanged route, _ ) ->
            setRoute route model

        ( UrlRequested urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.navKey (Url.toString url)
                    )

                Browser.External href ->
                    ( model
                    , Nav.load href
                    )

        ( UrlChanged url, _ ) ->
            setRoute (Route.fromUrl url) model

        ( _, NotFound ) ->
            ( { model | page = NotFound }
            , Cmd.none
            )

        ( _, _ ) ->
            ( model
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.page of
        HomePage _ ->
            Sub.none

        CounterPage _ ->
            Sub.none

        NotFound ->
            Sub.none

        Blank ->
            Sub.none


view : Model -> Document Msg
view model =
    let
        pageConfig =
            Page.Config model.session

        mapMsg msg ( title, content ) =
            ( title, content |> List.map (Html.map msg) )
    in
    case model.page of
        HomePage homeModel ->
            Home.view model.session homeModel
                |> mapMsg HomeMsg
                |> Page.frame (pageConfig Page.Home)

        CounterPage counterModel ->
            Counter.view model.session counterModel
                |> mapMsg CounterMsg
                |> Page.frame (pageConfig Page.Counter)

        NotFound ->
            ( "Not Found", [ Html.text "Not found" ] )
                |> Page.frame (pageConfig Page.Other)

        Blank ->
            ( "", [] )
                |> Page.frame (pageConfig Page.Other)


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlRequested
        }

module Main exposing (..)

import Data.Session exposing (Session)
import Html exposing (..)
import Navigation exposing (Location)
import Page.Home as Home
import Page.Counter as Counter
import Route exposing (Route)
import Views.Page as Page


type alias Flags =
    {}


type Page
    = Blank
    | HomePage
    | NotFound
    | Counter Counter.Model


type alias Model =
    { page : Page
    , session : Session
    }


type Msg
    = CounterMsg Counter.Msg
    | SetRoute (Maybe Route)


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    case maybeRoute of
        Nothing ->
            { model | page = NotFound } ! []

        Just Route.Home ->
            { model | page = HomePage } ! []

        Just Route.Counter ->
            let
                ( counterModel, counterCmds ) =
                    Counter.init
            in
                { model | page = Counter counterModel }
                    ! [ Cmd.map CounterMsg counterCmds ]


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    let
        -- you'll usually want to retrieve and decode serialized session
        -- information from flags here
        session =
            {}
    in
        setRoute (Route.fromLocation location)
            { page = Blank
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
                { model | page = toModel newModel }
                    ! [ Cmd.map toMsg newCmd ]
    in
        case ( msg, page ) of
            ( SetRoute route, _ ) ->
                setRoute route model

            ( _, HomePage ) ->
                { model | page = HomePage } ! []

            ( CounterMsg counterMsg, Counter counterModel ) ->
                toPage Counter CounterMsg (Counter.update session) counterMsg counterModel

            ( _, NotFound ) ->
                { model | page = NotFound } ! []

            ( _, _ ) ->
                model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.page of
        HomePage ->
            Sub.none

        Counter _ ->
            Sub.none

        NotFound ->
            Sub.none

        Blank ->
            Sub.none


view : Model -> Html Msg
view model =
    let
        pageConfig =
            Page.Config model.session
    in
        case model.page of
            HomePage ->
                Home.view model.session
                    |> Page.frame (pageConfig Page.Home)

            Counter counterModel ->
                Counter.view model.session counterModel
                    |> Html.map CounterMsg
                    |> Page.frame (pageConfig Page.Counter)

            NotFound ->
                Html.div [] [ Html.text "Not found" ]
                    |> Page.frame (pageConfig Page.Other)

            Blank ->
                Html.text ""
                    |> Page.frame (pageConfig Page.Other)


main : Program Flags Model Msg
main =
    Navigation.programWithFlags (Route.fromLocation >> SetRoute)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

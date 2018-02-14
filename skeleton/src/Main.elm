module Main exposing (main)

import Data.Session exposing (Session)
import Html exposing (..)
import Navigation exposing (Location)
import Page.Home as Home
import Page.Counter as Counter
import Page.CurrentTime as CurrentTime
import Route exposing (Route)
import Views.Page as Page


type alias Flags =
    {}


type Page
    = Blank
    | HomePage Home.Model
    | Counter Counter.Model
    | CurrentTime CurrentTime.Model
    | NotFound


type alias Model =
    { page : Page
    , session : Session
    }


type Msg
    = HomeMsg Home.Msg
    | CounterMsg Counter.Msg
    | CurrentTimeMsg CurrentTime.Msg
    | SetRoute (Maybe Route)


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    case maybeRoute of
        Nothing ->
            { model | page = NotFound } ! []

        Just Route.Home ->
            let
                ( homeModel, homeCmds ) =
                    Home.init model.session
            in
                { model | page = HomePage homeModel }
                    ! [ Cmd.map HomeMsg homeCmds ]

        Just Route.Counter ->
            let
                ( counterModel, counterCmds ) =
                    -- FIXME: pass session
                    Counter.init
            in
                { model | page = Counter counterModel }
                    ! [ Cmd.map CounterMsg counterCmds ]

        Just Route.CurrentTime ->
            let
                ( currentTimeModel, currentTimeCmds ) =
                    CurrentTime.init model.session
            in
                { model | page = CurrentTime currentTimeModel }
                    ! [ Cmd.map CurrentTimeMsg currentTimeCmds ]


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

            ( HomeMsg homeMsg, HomePage homeModel ) ->
                toPage HomePage HomeMsg (Home.update session) homeMsg homeModel

            ( CounterMsg counterMsg, Counter counterModel ) ->
                toPage Counter CounterMsg (Counter.update session) counterMsg counterModel

            ( CurrentTimeMsg currentTimeMsg, CurrentTime currentTimeModel ) ->
                toPage CurrentTime CurrentTimeMsg (CurrentTime.update session) currentTimeMsg currentTimeModel

            ( _, NotFound ) ->
                { model | page = NotFound } ! []

            ( _, _ ) ->
                model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.page of
        HomePage _ ->
            Sub.none

        Counter _ ->
            Sub.none

        CurrentTime model ->
            CurrentTime.subscriptions model
                |> Sub.map CurrentTimeMsg

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
            HomePage homeModel ->
                Home.view model.session homeModel
                    |> Page.frame (pageConfig Page.Home)

            Counter counterModel ->
                Counter.view model.session counterModel
                    |> Html.map CounterMsg
                    |> Page.frame (pageConfig Page.Counter)

            CurrentTime currentTimeModel ->
                CurrentTime.view model.session currentTimeModel
                    |> Html.map CurrentTimeMsg
                    |> Page.frame (pageConfig Page.CurrentTime)

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

module Main exposing (..)

import Data.Session exposing (Session)
import Html exposing (..)
import Page.Home as Home
import Page.SecondPage as SecondPage


type Page
    = HomePage Home.Model
    | SecondPage


type alias Model =
    { page : Page
    , session : Session
    }


type Msg
    = HomeMsg Home.Msg


init : ( Model, Cmd Msg )
init =
    let
        -- you'll usually want to retrieve and decode serialized session
        -- information from flags here
        session =
            {}

        ( homeModel, cmds ) =
            Home.init
    in
        { page = HomePage homeModel
        , session = session
        }
            ! [ cmds |> Cmd.map HomeMsg ]


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
            ( HomeMsg homeMsg, HomePage homeModel ) ->
                toPage HomePage HomeMsg (Home.update session) homeMsg homeModel

            ( _, SecondPage ) ->
                { model | page = SecondPage } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.page of
        HomePage modelHome ->
            Sub.none

        SecondPage ->
            Sub.none


view : Model -> Html Msg
view model =
    case model.page of
        HomePage homeModel ->
            Home.view model.session homeModel
                |> Html.map HomeMsg

        SecondPage ->
            SecondPage.view model.session


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

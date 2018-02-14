module Page.CurrentTime exposing (Model, Msg(..), init, update, subscriptions, view)

import Data.Date exposing (formatDate)
import Data.Session exposing (Session)
import Html exposing (..)
import Route
import Task
import Time exposing (Time)


type alias Model =
    { time : Time
    }


type Msg
    = NewTime Time


init : Session -> ( Model, Cmd Msg )
init session =
    { time = 0 } ! [ Task.perform NewTime Time.now ]


update : Session -> Msg -> Model -> ( Model, Cmd Msg )
update session msg model =
    case msg of
        NewTime time ->
            { model | time = time } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every Time.second NewTime


view : Session -> Model -> Html Msg
view session model =
    div []
        [ h2 [] [ text "What time is it?" ]
        , p [] [ model.time |> formatDate |> text ]
        , p [] [ a [ Route.href Route.Home ] [ text "Back to home" ] ]
        ]

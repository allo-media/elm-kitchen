module Page.Home exposing (..)

import Data.Counter exposing (Counter)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { counter : Counter
    }


type Msg
    = Add
    | Substract
    | SetInterval Int


init : ( Model, Cmd Msg )
init =
    { counter = { value = 1, interval = 10 } } ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ counter } as model) =
    case msg of
        Add ->
            { model | counter = { counter | value = counter.value + counter.interval } } ! []

        Substract ->
            { model | counter = { counter | value = counter.value - counter.interval } } ! []

        SetInterval interval ->
            { model | counter = { counter | interval = interval } } ! []


onInputInterval : String -> Msg
onInputInterval str =
    str
        |> String.toInt
        |> Result.withDefault 0
        |> SetInterval


view : Model -> Html Msg
view ({ counter } as model) =
    div []
        [ span [] [ text (toString counter.value) ]
        , button [ onClick <| Substract ] [ text "-" ]
        , button [ onClick <| Add ] [ text "+" ]
        , p
            []
            [ input
                [ onInput onInputInterval
                , value <| toString counter.interval
                ]
                []
            ]
        ]

module Page.Counter exposing (Model, Msg(..), init, update, view)

import Data.Counter exposing (Counter)
import Data.Session exposing (Session)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route


type alias Model =
    { counter : Counter
    }


type Msg
    = Add
    | Substract
    | SetInterval Int


init : ( Model, Cmd Msg )
init =
    { counter = { value = 1, interval = 5 } } ! []


update : Session -> Msg -> Model -> ( Model, Cmd Msg )
update session msg ({ counter } as model) =
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


view : Session -> Model -> Html Msg
view session ({ counter } as model) =
    div []
        [ h2 [] [ text "Counter" ]
        , div [ class "counter" ]
            [ p []
                [ button [ onClick <| Substract ] [ text "-" ]
                , strong [] [ text <| toString counter.value ]
                , button [ onClick <| Add ] [ text "+" ]
                ]
            , p []
                [ input
                    [ type_ "range"
                    , onInput onInputInterval
                    , value <| toString counter.interval
                    , Html.Attributes.min "1"
                    , Html.Attributes.max "10"
                    , size 3
                    ]
                    []
                , br [] []
                , text "Amount = "
                , text <| toString counter.interval
                ]
            ]
        , p [] [ a [ Route.href Route.Home ] [ text "Back to home" ] ]
        ]

module Page.Counter exposing (Model, Msg, init, update, view)

import Css exposing (fontSize, marginRight)
import Data.Context exposing (Context)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Route


type alias Model =
    Int


type Msg
    = Inc


init : Context -> ( Model, Cmd Msg )
init _ =
    ( 0, Cmd.none )


update : Context -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        Inc ->
            ( model + 1
            , Cmd.none
            )


view : Context -> Model -> ( String, List (Html Msg) )
view _ model =
    ( "Second Page"
    , [ h1 [] [ text "Second page" ]
      , p [] [ text "This is the second page, featuring a counter." ]
      , p []
            [ button
                [ css [ fontSize (Css.rem 1.2), marginRight (Css.px 10) ]
                , onClick Inc
                ]
                [ text "+" ]
            , strong [] [ text (String.fromInt model) ]
            ]
      , p [] [ a [ Route.href Route.Home ] [ text "Back home" ] ]
      ]
    )

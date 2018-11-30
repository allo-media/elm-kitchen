module Page.Counter exposing (Model, Msg, init, update, view)

import Css exposing (fontSize, margin2, zero)
import Data.Session as Session exposing (Session)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Ports
import Route
import Views.Theme exposing (Element)


type alias Model =
    Int


type Msg
    = Dec
    | Inc
    | Reset


init : Session -> ( Model, Session, Cmd Msg )
init session =
    ( session.store.counter, session, Cmd.none )


update : Session -> Msg -> Model -> ( Model, Session, Cmd Msg )
update ({ store } as session) msg model =
    case msg of
        Dec ->
            ( model - 1
            , { session | store = { store | counter = model - 1 } }
            , Cmd.none
            )

        Inc ->
            ( model + 1
            , { session | store = { store | counter = model + 1 } }
            , Cmd.none
            )

        Reset ->
            ( 0
            , { session | store = { store | counter = 0 } }
            , Cmd.none
            )


btn : Element msg
btn =
    styled button
        [ fontSize (Css.rem 1.2)
        , margin2 zero (Css.px 10)
        ]


view : Session -> Model -> ( String, List (Html Msg) )
view _ model =
    ( "Second Page"
    , [ h1 [] [ text "Second page" ]
      , p [] [ text "This is the second page, featuring a counter." ]
      , p []
            [ btn [ onClick Dec ] [ text "-" ]
            , strong [] [ text (String.fromInt model) ]
            , btn [ onClick Inc ] [ text "+" ]
            , btn [ onClick Reset ] [ text "reset" ]
            ]
      , p [] [ a [ Route.href Route.Home ] [ text "Back home" ] ]
      ]
    )

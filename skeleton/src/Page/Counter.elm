module Page.Counter exposing (Model, Msg, init, update, view)

import Css exposing (fontSize, marginRight)
import Data.Session as Session exposing (Session)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Ports
import Route


type alias Model =
    Int


type Msg
    = Inc


init : Session -> ( Model, Session, Cmd Msg )
init session =
    ( session.store.counter, session, Cmd.none )


update : Session -> Msg -> Model -> ( Model, Session, Cmd Msg )
update ({ store } as session) msg model =
    let
        newCount =
            model + 1

        newStore =
            { store | counter = newCount }
    in
    case msg of
        Inc ->
            ( newCount
            , { session | store = newStore }
            , newStore |> Session.serializeStore |> Ports.saveStore
            )


view : Session -> Model -> ( String, List (Html Msg) )
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

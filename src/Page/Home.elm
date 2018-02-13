module Page.Home exposing (..)

import Data.Session exposing (Session)
import Html exposing (..)
import Route


view : Session -> Html msg
view session =
    div []
        [ h2 [] [ text "This is a sample SPA written in Elm." ]
        , p []
            [ text "This is blah blah blah. "
            , text "Feel free to play around with our marvellous "
            , a [ Route.href Route.Counter ] [ text "Counter" ]
            ]
        ]

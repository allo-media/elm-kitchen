module Page.SecondPage exposing (..)

import Data.Session exposing (Session)
import Html exposing (..)
import Route


view : Session -> Html msg
view session =
    div []
        [ p [] [ text "This is the second page." ]
        , p [] [ a [ Route.href Route.Home ] [ text "Go back to the homepage" ] ]
        ]

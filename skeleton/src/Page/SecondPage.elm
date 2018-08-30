module Page.SecondPage exposing (view)

import Data.Session exposing (Session)
import Html.Styled as Html exposing (..)
import Route


view : Session -> ( String, List (Html msg) )
view session =
    ( "Second Page"
    , [ h1 [] [ text "Second page" ]
      , p [] [ text "This is the second page." ]
      , p [] [ a [ Route.href Route.Home ] [ text "Back home" ] ]
      ]
    )

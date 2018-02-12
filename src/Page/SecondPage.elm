module Page.SecondPage exposing (..)

import Data.Session exposing (Session)
import Html exposing (..)


view : Session -> Html msg
view session =
    div [] [ p [] [ text "This is the second page." ] ]

module Page.SecondPage exposing (view)

import Html.Styled exposing (..)
import Route


view : Html msg
view =
    div []
        [ h1 [] [ text "Second page" ]
        , p [] [ text "This is the second page." ]
        , p [] [ a [ Route.href Route.Home ] [ text "Back home" ] ]
        ]

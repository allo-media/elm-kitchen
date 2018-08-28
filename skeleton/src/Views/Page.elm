module Views.Page exposing (ActivePage(..), Config, frame)

import Browser exposing (Document)
import Data.Session exposing (Session)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class)


type ActivePage
    = Home
    | Other


type alias Config =
    { session : Session
    , activePage : ActivePage
    }


frame : Config -> Html msg -> Document msg
frame _ content =
    { title = "test"
    , body =
        [ h1 [] [ text "Crash test" ] |> toUnstyled

        -- This works
        , div [] [] |> toUnstyled

        -- This crashes the runtime
        , div [ class "plop" ] [] |> toUnstyled
        ]
    }

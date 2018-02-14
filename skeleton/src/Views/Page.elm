module Views.Page exposing (ActivePage(..), Config, frame)

import Html exposing (..)
import Html.Attributes exposing (class, classList, href)
import Data.Session exposing (Session)
import Route


type ActivePage
    = Home
    | Counter
    | CurrentTime
    | Other


type alias Config =
    { session : Session
    , activePage : ActivePage
    }


frame : Config -> Html msg -> Html msg
frame ({ activePage, session } as config) content =
    div
        [ classList
            [ ( "page-home", activePage == Home )
            , ( "page-counter", activePage == Counter )
            , ( "page-current-time", activePage == CurrentTime )
            ]
        ]
        [ viewHeader config
        , div [ class "page-content" ] [ content ]
        ]


viewHeader : Config -> Html msg
viewHeader { session, activePage } =
    let
        navEntry page route label =
            li [ classList [ ( "active", page == activePage ) ] ]
                [ a [ Route.href route ] [ text label ] ]
    in
        div [ class "header" ]
            [ h1 [] [ text "elm-create-spa" ]
            , ul []
                [ navEntry Home Route.Home "Home"
                , navEntry Counter Route.Counter "Counter"
                , navEntry CurrentTime Route.CurrentTime "Current time"
                ]
            , a
                [ Html.Attributes.target "_blank"
                , class "github-link"
                , href "https://github.com/allo-media/elm-create-spa"
                ]
                [ text "Github" ]
            ]

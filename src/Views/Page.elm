module Views.Page exposing (ActivePage(..), Config, frame)

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Data.Session exposing (Session)
import Route


type ActivePage
    = Home
    | SecondPage
    | Other


type alias Config =
    { session : Session
    , activePage : ActivePage
    }


frame : Config -> Html msg -> Html msg
frame ({ activePage, session } as config) content =
    div
        [ classList
            [ ( "page-frame", True )
            , ( "page-home", activePage == Home )
            , ( "page-second-page", activePage == SecondPage )
            ]
        ]
        [ viewHeader config
        , content
        ]


viewHeader : Config -> Html msg
viewHeader { session, activePage } =
    let
        navEntry page route label =
            li [ classList [ ( "active", page == activePage ) ] ]
                [ a [ Route.href route ] [ text label ] ]
    in
        div [ class "header" ]
            [ h1 [ class "elm-create-app" ] [ text "elm-create-app" ]
            , ul []
                [ navEntry Home Route.Home "Home"
                , navEntry SecondPage Route.SecondPage "Second page"
                ]
            ]

module Views.Page exposing (ActivePage(..), Config, frame)

import Css exposing (..)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (class, classList, href, css)
import Data.Session exposing (Session)
import Route
import Views.Theme exposing (defaultCss, Element)


type ActivePage
    = Home
    | Other


type alias Config =
    { session : Session
    , activePage : ActivePage
    }


frame : Config -> Html msg -> Html msg
frame ({ activePage, session } as config) content =
    div []
        [ defaultCss
        , viewHeader config
        , div [ css [ padding2 (Css.em 1) zero ] ] [ content ]
        ]


githubIconStyle : Element msg
githubIconStyle =
    styled a
        [ position absolute
        , top (px 15)
        , right (px 15)
        , border3 (px 1) solid (rgba 255 255 255 0.3)
        , padding (px 10)
        , borderRadius (px 4)
        , color (hex "999")
        , textDecoration none
        , before
            [ property "content" "url('data:image/svg+xml; utf8, <svg role=\"img\" viewBox=\"0 0 24 24\" xmlns=\"http://www.w3.org/2000/svg\"><path fill=\"#999\" d=\"M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12\"/></svg>')"
            ]
        ]


title : Element msg
title =
    styled h1
        [ textAlign center
        , margin2 (Css.em 1) zero
        , color (hex "333")
        , fontSize (px 60)
        , lineHeight (px 1)
        ]


viewHeader : Config -> Html msg
viewHeader { session, activePage } =
    let
        navEntry page route label =
            li []
                [ a [ Route.href route ] [ text label ] ]
    in
        div [ class "header" ]
            [ title [] [ text "elm-kitchen" ]
            , githubIconStyle
                [ Html.Styled.Attributes.target "_blank"
                , href "https://github.com/allo-media/elm-kitchen"
                ]
                [ text "Github" ]
            ]

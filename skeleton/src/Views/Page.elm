module Views.Page exposing (ActivePage(..), Config, frame)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, href, css, src)
import Data.Session exposing (Session)
import Views.Theme exposing (defaultCss, Element)


type ActivePage
    = Home
    | Other


type alias Config =
    { session : Session
    , activePage : ActivePage
    }


frame : Config -> Html msg -> Html msg
frame config content =
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
        ]


title : Element msg
title =
    styled h1
        [ textAlign center
        , margin2 (Css.em 1) zero
        , color (hex "000")
        , fontSize (px 60)
        , lineHeight (px 1)
        ]


viewHeader : Config -> Html msg
viewHeader _ =
    div [ class "header" ]
        [ title [] [ text "elm-kitchen" ]
        , githubIconStyle
            [ Html.Styled.Attributes.target "_blank"
            , href "https://github.com/allo-media/elm-kitchen"
            ]
            [ img
                [ src "https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ei-sc-github.svg/768px-Ei-sc-github.svg.png"
                , css
                    [ width (px 96)
                    , height (px 96)
                    , float left
                    ]
                ]
                []
            , span [ css [ color (hex "000"), display block, textAlign center ] ] [ text "Github" ]
            ]
        ]

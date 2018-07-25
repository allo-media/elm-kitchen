module Views.Theme exposing (Element, defaultCss, theme)

import Css exposing (..)
import Css.Foreign exposing (body, global, html, img)
import Html.Styled exposing (Attribute, Html)


type alias Theme =
    { primaryColor : Color
    , primaryBgColor : Color
    , secondaryBgColor : Color
    , fonts : List String
    }


type alias Element msg =
    List (Attribute msg) -> List (Html msg) -> Html msg


theme : Theme
theme =
    { primaryColor = hex "333"
    , primaryBgColor = hex "b01246"
    , secondaryBgColor = hex "fafafa"
    , fonts = [ "Lato", .value sansSerif ]
    }


defaultCss : Html msg
defaultCss =
    global
        [ html
            [ backgroundColor theme.secondaryBgColor
            , width (pct 100)
            , height (pct 100)
            ]
        , body
            [ color theme.primaryColor
            , margin2 (pct 0) auto
            , width (px 640)
            , fontFamilies theme.fonts
            ]
        , img
            [ width (px 640) ]
        ]

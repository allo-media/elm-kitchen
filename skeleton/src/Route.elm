module Route exposing (Route(..), fromUrl, href, pushUrl)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Html.Styled exposing (Attribute)
import Html.Styled.Attributes as Attr
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s, string)


type Route
    = Home
    | SecondPage


parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map Home Parser.top
        , Parser.map SecondPage (s "second-page")
        ]


href : Route -> Attribute msg
href route =
    Attr.href (routeToString route)


fromUrl : Url -> Maybe Route
fromUrl url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Parser.parse parser


routeToString : Route -> String
routeToString route =
    let
        pieces =
            case route of
                Home ->
                    []

                SecondPage ->
                    [ "second-page" ]
    in
    "#/" ++ String.join "/" pieces


pushUrl : Nav.Key -> Route -> Cmd msg
pushUrl key route =
    Nav.pushUrl key (routeToString route)

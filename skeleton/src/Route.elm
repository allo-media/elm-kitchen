module Route exposing (Route(..), fromUrl, href, modifyUrl)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Html.Styled exposing (Attribute)
import Html.Styled.Attributes as Attr
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s, string)


type Route
    = Home
    | SecondPage (Maybe String)


parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map Home Parser.top
        , Parser.map (SecondPage Nothing) (s "second-page")
        , Parser.map (SecondPage << Just) (s "second-page" </> Parser.string)
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

                SecondPage Nothing ->
                    [ "second-page" ]

                SecondPage (Just id) ->
                    [ "second-page", id ]
    in
    "#/" ++ String.join "/" pieces


modifyUrl : Nav.Key -> Route -> Cmd msg
modifyUrl key route =
    Nav.pushUrl key (routeToString route)

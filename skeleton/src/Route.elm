module Route exposing (Route(..), fromLocation, href, modifyUrl)

import Html.Styled as Html exposing (Attribute)
import Html.Styled.Attributes as Attr
import Navigation exposing (Location)
import UrlParser as Url exposing (Parser, s)


type Route
    = Home


route : Parser (Route -> a) a
route =
    Url.oneOf
        [ Url.map Home Url.top
        ]


href : Route -> Attribute msg
href route =
    Attr.href (routeToString route)


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Home
    else
        Url.parseHash route location


routeToString : Route -> String
routeToString route =
    let
        pieces =
            case route of
                Home ->
                    []
    in
        "#/" ++ String.join "/" pieces


modifyUrl : Route -> Cmd msg
modifyUrl =
    routeToString >> Navigation.modifyUrl
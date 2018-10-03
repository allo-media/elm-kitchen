module Data.Session exposing (Session)

import Browser.Navigation as Nav


type alias Session =
    { navKey : Nav.Key }

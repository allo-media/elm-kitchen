module Data.Context exposing (Context)

import Browser.Navigation as Nav
import Data.Session exposing (Session)


type alias Context =
    { navKey : Nav.Key
    , session : Session
    }

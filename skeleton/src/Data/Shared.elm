module Data.Shared exposing (Shared)

import Browser.Navigation as Nav
import Data.Session exposing (Session)


type alias Shared =
    { navKey : Nav.Key
    , session : Session
    }

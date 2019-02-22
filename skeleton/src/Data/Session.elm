module Data.Session exposing (Session, Store, defaultStore)

import Browser.Navigation as Nav


type alias Session =
    { navKey : Nav.Key
    , clientUrl : String
    , store : Store
    }


{-| A serializable data structure holding session information you want to share
across browser restarts, typically in localStorage.
-}
type alias Store =
    { counter : Int }


defaultStore : Store
defaultStore =
    { counter = 0 }

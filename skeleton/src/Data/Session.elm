module Data.Session exposing (Session, Store, decodeStore, encodeStore)

import Browser.Navigation as Nav
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


{-| A serializable data structure holding session information you want to share
across browser restarts, typically in localStorage.
-}
type alias Store =
    { counter : Int }


type alias Session =
    { navKey : Nav.Key
    , clientUrl : String
    , store : Store
    }


decodeStore : Decoder Store
decodeStore =
    Decode.map Store
        (Decode.field "counter" Decode.int)


encodeStore : Store -> Encode.Value
encodeStore v =
    Encode.object
        [ ( "counter", Encode.int v.counter )
        ]

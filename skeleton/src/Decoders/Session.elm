module Decoders.Session exposing (deserializeStore)

import Data.Session exposing (Store, defaultStore)
import Json.Decode as Decode exposing (Decoder)


decodeStore : Decoder Store
decodeStore =
    Decode.map Store
        (Decode.field "counter" Decode.int)


deserializeStore : String -> Store
deserializeStore =
    Decode.decodeString decodeStore >> Result.withDefault defaultStore

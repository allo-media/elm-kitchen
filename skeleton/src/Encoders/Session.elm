module Encoders.Session exposing (serializeStore)

import Data.Session exposing (Store)
import Json.Encode as Encode


encodeStore : Store -> Encode.Value
encodeStore v =
    Encode.object
        [ ( "counter", Encode.int v.counter )
        ]


serializeStore : Store -> String
serializeStore =
    encodeStore >> Encode.encode 0

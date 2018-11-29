port module Ports exposing (saveStore, storeChanged)

import Json.Encode as Encode


port saveStore : Encode.Value -> Cmd msg


port storeChanged : (Encode.Value -> msg) -> Sub msg

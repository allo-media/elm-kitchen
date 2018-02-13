module Data.Date exposing (formatDate)

import Date
import Date.Extra exposing (toFormattedString)
import Time exposing (Time)


formatDate : Time -> String
formatDate time =
    time
        |> Date.fromTime
        |> toFormattedString "EEEE, MMMM d, h:mm:ss a"

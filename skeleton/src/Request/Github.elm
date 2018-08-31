module Request.Github exposing (errorToString, getReadme)

import Data.Session exposing (Session)
import Http exposing (Error(..), Request, getString)


errorToString : Http.Error -> String
errorToString error =
    case error of
        BadUrl _ ->
            "Bad url."

        Timeout ->
            "Request timed out."

        NetworkError ->
            "Network error. Are you online?"

        BadStatus response ->
            "HTTP error " ++ String.fromInt response.status.code

        BadPayload _ _ ->
            "Unable to parse response body."


getReadme : Session -> Request String
getReadme _ =
    getString "README.md"

module Request.Github exposing (getReadme)

import Data.Session exposing (Session)
import Http exposing (Request, getString)


getReadme : Session -> Request String
getReadme _ =
    getString "https://raw.githubusercontent.com/allo-media/elm-kitchen/master/README.md"

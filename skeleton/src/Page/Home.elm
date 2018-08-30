module Page.Home exposing (Model, Msg(..), init, update, view)

import Browser exposing (Document)
import Data.Session exposing (Session)
import Html.Styled as Html exposing (..)
import Http
import Markdown
import Request.Github as Github
import Task


type alias Model =
    { readme : String
    }


type Msg
    = ReadmeReceived (Result Http.Error String)


init : Session -> ( Model, Cmd Msg )
init session =
    ( { readme = "Retrieving README from github" }
    , Github.getReadme session |> Http.send ReadmeReceived
    )


errorToMarkdown : Http.Error -> String
errorToMarkdown error =
    """## Error

There was an error attempting to retrieve README information:

> *""" ++ Github.errorToString error ++ "*"


update : Session -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        ReadmeReceived (Ok readme) ->
            ( { model | readme = readme }
            , Cmd.none
            )

        ReadmeReceived (Err error) ->
            ( { model | readme = errorToMarkdown error }
            , Cmd.none
            )


view : Session -> Model -> ( String, List (Html Msg) )
view _ model =
    ( "Home"
    , [ model.readme
            |> Markdown.toHtml []
            |> Html.fromUnstyled
      ]
    )

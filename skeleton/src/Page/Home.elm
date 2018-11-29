module Page.Home exposing (Model, Msg(..), init, update, view)

import Browser exposing (Document)
import Data.Shared exposing (Shared)
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


init : Shared -> ( Model, Shared, Cmd Msg )
init shared =
    ( { readme = "Retrieving README from github" }
    , shared
    , Github.getReadme shared.session |> Http.send ReadmeReceived
    )


errorToMarkdown : Http.Error -> String
errorToMarkdown error =
    """## Error

There was an error attempting to retrieve README information:

> *""" ++ Github.errorToString error ++ "*"


update : Shared -> Msg -> Model -> ( Model, Shared, Cmd Msg )
update shared msg model =
    case msg of
        ReadmeReceived (Ok readme) ->
            ( { model | readme = readme }
            , shared
            , Cmd.none
            )

        ReadmeReceived (Err error) ->
            ( { model | readme = errorToMarkdown error }
            , shared
            , Cmd.none
            )


view : Shared -> Model -> ( String, List (Html Msg) )
view _ model =
    ( "Home"
    , [ model.readme
            |> Markdown.toHtml []
            |> Html.fromUnstyled
      ]
    )

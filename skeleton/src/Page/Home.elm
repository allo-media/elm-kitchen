module Page.Home exposing (Model, Msg(..), init, update, view)

import Browser exposing (Document)
import Data.Context exposing (Context)
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


init : Context -> ( Model, Context, Cmd Msg )
init context =
    ( { readme = "Retrieving README from github" }
    , context
    , Github.getReadme context.session |> Http.send ReadmeReceived
    )


errorToMarkdown : Http.Error -> String
errorToMarkdown error =
    """## Error

There was an error attempting to retrieve README information:

> *""" ++ Github.errorToString error ++ "*"


update : Context -> Msg -> Model -> ( Model, Context, Cmd Msg )
update context msg model =
    case msg of
        ReadmeReceived (Ok readme) ->
            ( { model | readme = readme }
            , context
            , Cmd.none
            )

        ReadmeReceived (Err error) ->
            ( { model | readme = errorToMarkdown error }
            , context
            , Cmd.none
            )


view : Context -> Model -> ( String, List (Html Msg) )
view _ model =
    ( "Home"
    , [ model.readme
            |> Markdown.toHtml []
            |> Html.fromUnstyled
      ]
    )

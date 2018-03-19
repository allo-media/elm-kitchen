module Page.Home exposing (Model, Msg(..), init, update, view)

import Data.Session exposing (Session)
import Html exposing (..)
import Html.Attributes exposing (class)
import Http
import Markdown
import Request.Github exposing (getReadme)
import Task


type alias Model =
    { readme : String
    }


type Msg
    = ReadmeReceived (Result Http.Error String)


init : Session -> ( Model, Cmd Msg )
init session =
    { readme = "Retrieving README from github" }
        ! [ getReadme session
                |> Http.toTask
                |> Task.attempt ReadmeReceived
          ]


errorToMarkdown : Http.Error -> String
errorToMarkdown error =
    """
    ## Error

    There was an error attempting to retrieve README information:

        """ ++ toString error


update : Session -> Msg -> Model -> ( Model, Cmd Msg )
update session msg model =
    case msg of
        ReadmeReceived (Ok readme) ->
            { model | readme = readme } ! []

        ReadmeReceived (Err error) ->
            { model | readme = errorToMarkdown error } ! []


view : Session -> Model -> Html msg
view session model =
    div []
        [ Markdown.toHtml [ class "content readme" ] model.readme
        ]

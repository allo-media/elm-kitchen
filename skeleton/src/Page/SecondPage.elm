module Page.SecondPage exposing (Model, Msg, init, update, view)

import Data.Session exposing (Session)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Route


type alias Model =
    { selectedId : Maybe String
    }


type Msg
    = NoOp


type Size
    = Large
    | Small


init : Session -> Maybe String -> ( Model, Cmd Msg )
init session maybeId =
    ( { selectedId = maybeId }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


buttonView : Size -> String -> Html Msg
buttonView size txt =
    case size of
        Large ->
            button [ attribute "style" "font-size:2em" ] [ text txt ]

        Small ->
            button [] [ text txt ]


buttonStories : List { id : String, state : ( Size, String ) }
buttonStories =
    [ { id = "a-small-button", state = ( Small, "exemple 1" ) }
    , { id = "a-larger-button", state = ( Large, "exemple 2" ) }
    ]


renderButtonStory : ( Size, String ) -> Html Msg
renderButtonStory ( size, string ) =
    buttonView size string


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Buttons" ]
        , buttonStories
            |> List.map (\{ id } -> li [] [ a [ Route.href (Route.SecondPage (Just id)) ] [ text id ] ])
            |> ul []
        , case model.selectedId of
            Just id ->
                case
                    buttonStories
                        |> List.filter (\story -> story.id == id)
                        |> List.head
                of
                    Just story ->
                        renderButtonStory story.state

                    Nothing ->
                        text "Select a valid story"

            Nothing ->
                text "Select a story"
        , h2 [] [ text "Other" ]
        , p [] [ text "todo" ]
        ]

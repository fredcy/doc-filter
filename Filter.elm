module Filter exposing (..)

import Html exposing (Html)
import Html.App as Html
import Html.Attributes as Html
import Html.Events as Html
import Regex


main : Program Flags
main =
    Html.programWithFlags
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


type alias Flags =
    List Section


type alias Filter =
    Maybe String


type alias Section =
    { id : String, text : String, content : String }


type alias Model =
    { message : String
    , sections : Flags
    , filter : Filter
    }


type Msg
    = UpdateFilter String
    | ResetFilter


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { message = "Hello", sections = flags, filter = Nothing }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg |> Debug.log "msg" of
        UpdateFilter filterString ->
            let
                filter =
                    if filterString == "" then
                        Nothing
                    else
                        Just filterString
            in
                { model | filter = filter } ! []

        ResetFilter ->
            { model | filter = Nothing } ! []


view : Model -> Html Msg
view model =
    Html.div []
        [ filterInput model
        , resetButton model
        , sectionList model
        ]


sectionList : Model -> Html Msg
sectionList model =
    let
        link id text =
            Html.a [ Html.href ("#" ++ id) ] [ Html.text text ]

        sectionListItem section =
            Html.li [] [ link section.id section.text ]
    in
        Html.ul [ Html.class "section-list" ]
            (filterSections model.filter model.sections
                |> List.map sectionListItem
            )


filterSections : Filter -> List Section -> List Section
filterSections filter sections =
    let
        matches section =
            case filter of
                Just pattern ->
                    let
                        regex =
                            Regex.regex pattern |> Regex.caseInsensitive
                    in
                        (Regex.contains regex section.text
                            || Regex.contains regex section.content
                        )

                Nothing ->
                    True
    in
        List.filter matches sections


filterInput : Model -> Html Msg
filterInput model =
    let
        val =
            model.filter |> Maybe.withDefault ""
    in
        Html.input [ Html.onInput UpdateFilter, Html.value val, Html.class "filter" ] []


resetButton : Model -> Html Msg
resetButton model =
    case model.filter of
        Just _ ->
            Html.button [ Html.onClick ResetFilter, Html.class "reset-filter" ] [ Html.text "reset" ]

        Nothing ->
            Html.text ""

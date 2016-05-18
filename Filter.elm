module Filter exposing (..)

import Html
import Html.App as Html
import Html.Attributes as Html


main : Program Flags
main =
    Html.programWithFlags
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


type alias Flags =
    List SectionInfo


type alias SectionInfo =
    { id : String, text : String }


type alias Model =
    { message : String
    , sections : Flags
    }


type Msg
    = NoOp


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { message = "Hello", sections = flags }, Cmd.none )


update msg model =
    ( model, Cmd.none )


view model =
    Html.div []
        [ sectionList model
        ]


sectionList model =
    let
        link id text =
            Html.a [ Html.href ("#" ++ id) ] [ Html.text text ]

        sectionListItem section =
            Html.li [] [ link section.id section.text ]
    in
        Html.ul [ Html.class "section-list" ] (List.map sectionListItem model.sections)

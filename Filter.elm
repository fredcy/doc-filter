module Filter exposing (..)

import Html
import Html.App as Html


main : Program Never
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


type alias Model =
    { message : String
    }


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    ( { message = "Hello" }, Cmd.none )


update msg model =
    ( model, Cmd.none )


view model =
  Html.div [] [ Html.text model.message ]
      

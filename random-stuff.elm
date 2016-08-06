module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App as App


main =
    App.beginnerProgram
        { model = initial
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { dice : Int
    }


initial : Model
initial =
    { dice = 6
    }



-- UPDATE


type Action
    = Roll


update : Action -> Model -> Model
update action model =
    case action of
        Roll ->
            { model | dice = model.dice - 1 }



-- VIEW


view : Model -> Html Action
view model =
    div []
        [ pre [] [ text (toString model.dice) ]
        , button [ onClick Roll ] [ text "Roll the dice!" ]
        ]

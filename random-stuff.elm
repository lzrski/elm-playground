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


initial : ( Model, Cmd Action )
initial =
    ( Model 6, Cmd.none )



-- UPDATE


type Action
    = Roll


update : Action -> ( Model, Cmd Action ) -> ( Model, Cmd Action )
update action ( model, command ) =
    case action of
        Roll ->
            ( { model | dice = model.dice - 1 }, Cmd.none )



-- subscriptions : Model -> Sub Action
-- VIEW


view : ( Model, Cmd Action ) -> Html Action
view ( model, command ) =
    div []
        [ pre [] [ text (toString model.dice) ]
        , button [ onClick Roll ] [ text "Roll the dice!" ]
        ]

module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Random
import Logger exposing (logger)


main =
    App.program
        { init = initial
        , view = Debug.log "Rendering" >> view
        , update = logger update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { dice : Maybe Int
    }


initial : ( Model, Cmd Action )
initial =
    ( Model Nothing, Cmd.none )



-- UPDATE


type Action
    = Roll
    | NewFace Int


update : Action -> Model -> ( Model, Cmd Action )
update action model =
    case action of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )

        NewFace number ->
            ( Model (Just number), Cmd.none )


subscriptions : Model -> Sub Action
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Action
view model =
    let
        message =
            case model.dice of
                Nothing ->
                    "C'mon, be a playa!"

                Just number ->
                    "Look, it's " ++ (number |> toString)
    in
        div []
            [ pre [] [ text message ]
            , button [ onClick Roll ] [ text "Roll the dice!" ]
            ]

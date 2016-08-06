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
    { dices : Maybe ( Int, Int )
    }


initial : ( Model, Cmd Action )
initial =
    ( Model Nothing, Cmd.none )



-- UPDATE


type Action
    = Roll
    | NewFace ( Int, Int )


d6 =
    Random.int 1 6


t2d6 =
    Random.pair d6 d6


update : Action -> Model -> ( Model, Cmd Action )
update action model =
    case action of
        Roll ->
            ( model, Random.generate NewFace t2d6 )

        NewFace ( a, b ) ->
            ( Model (Just ( a, b )), Cmd.none )


subscriptions : Model -> Sub Action
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Action
view model =
    let
        message =
            case model.dices of
                Nothing ->
                    "C'mon, be a playa!"

                Just ( a, b ) ->
                    "Look, it's "
                        ++ (a |> toString)
                        ++ " and "
                        ++ (b |> toString)
    in
        div []
            [ pre [] [ text message ]
            , button [ onClick Roll ] [ text "Roll the dice!" ]
            ]

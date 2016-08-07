module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Logger exposing (logger)
import Time exposing (Time, second)


main =
    App.program
        { init = initial
        , view = Debug.log "Rendering" >> view
        , update = logger update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { ticks : Int
    , enabled : Bool
    }


initial : ( Model, Cmd Action )
initial =
    ( Model 0 False, Cmd.none )



-- UPDATE


type Action
    = Tick Time
    | Tock Time
    | Toggle
    | Rollback


update : Action -> Model -> ( Model, Cmd Action )
update action model =
    let
        { ticks, enabled } =
            model
    in
        case action of
            Tick time ->
                ( { model | ticks = model.ticks + 1 }, Cmd.none )

            Tock time ->
                ( { model | ticks = model.ticks - 3 }, Cmd.none )

            Toggle ->
                ( { model | enabled = not enabled }, Cmd.none )

            Rollback ->
                ( { model | ticks = ticks - 10 }, Cmd.none )


subscriptions : Model -> Sub Action
subscriptions model =
    if model.enabled then
        Sub.batch
            [ Time.every (second / 2) Tick
            , Time.every (second * 2) Tock
            ]
    else
        Sub.none



-- VIEW


view : Model -> Html Action
view model =
    div []
        [ pre [] [ text (model.ticks |> toString) ]
        , button [ onClick Toggle ] [ text "Play" ]
        , button [ onClick Rollback ] [ text "Back!" ]
        ]

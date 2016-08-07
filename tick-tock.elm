module TickTock exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Logger exposing (logger)
import Time exposing (Time, second)


-- We can run it as a program of it's own


main =
    App.program
        { init = init
        , view = Debug.log "Rendering" >> view
        , update = logger update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { ticks : Int
    , enabled : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( Model 0 False, Cmd.none )



-- UPDATE


type Msg
    = Tick Time
    | Tock Time
    | Toggle
    | Rollback


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { ticks, enabled } =
            model
    in
        case msg of
            Tick time ->
                ( { model | ticks = model.ticks + 1 }, Cmd.none )

            Tock time ->
                ( { model | ticks = model.ticks - 3 }, Cmd.none )

            Toggle ->
                ( { model | enabled = not enabled }, Cmd.none )

            Rollback ->
                ( { model | ticks = ticks - 10 }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.enabled then
        Sub.batch
            [ Time.every (second / 2) Tick
            , Time.every (second * 2) Tock
            ]
    else
        Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ pre [] [ text (model.ticks |> toString) ]
        , button [ onClick Toggle ] [ text "Play" ]
        , button [ onClick Rollback ] [ text "Back!" ]
        ]

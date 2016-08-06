module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (onClick, onInput, onSubmit)
import Html.Attributes exposing (..)


main =
    App.beginnerProgram
        { model = initial
        , view = view
        , update = logger update
        }



-- MODEL


type alias Model =
    { cats : List Cat
    , input : Cat
    }


type alias Cat =
    String


initial : Model
initial =
    { cats =
        [ "Katiusza"
        , "Skubi"
        , "George"
        ]
    , input = ""
    }



-- UPDATE


type Action
    = Remove Cat
    | Select Cat
    | Add
    | Input Cat
    | Restore


logger update =
    \action model ->
        model |> (Debug.log "action" action |> update) |> Debug.log "model"


update action model =
    case action of
        Input cat ->
            { model | input = cat }

        Add ->
            if model.input == "" then
                model
            else
                { model
                    | cats = model.input :: model.cats
                    , input = ""
                }

        Remove cat ->
            let
                predicate item =
                    item /= cat
            in
                { model
                    | cats = List.filter predicate model.cats
                    , input = cat
                }

        Select cat ->
            let
                predicate item =
                    item == cat
            in
                { model | cats = List.filter predicate model.cats }

        Restore ->
            { model | cats = initial.cats }



-- VIEW


add_a_cat_form what =
    Html.form [ onSubmit Add ]
        [ input [ onInput Input, value what ] []
        , button []
            [ text "New cat!"
            ]
        ]


view model =
    div []
        [ add_a_cat_form model.input
        , ul []
            (List.map item model.cats)
        , button [ onClick Restore ]
            [ text "Restore kittens!"
            ]
        ]


item cat =
    li []
        [ a [ onClick (Select cat), href "#" ]
            [ text cat
            ]
        , button [ onClick (Remove cat) ]
            [ text "x"
            ]
        ]

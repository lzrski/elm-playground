module Logger exposing (logger)


logger update =
    \action model ->
        model |> (Debug.log "action" action |> update) |> Debug.log "model"

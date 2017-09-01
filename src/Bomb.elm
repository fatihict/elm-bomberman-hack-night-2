module Bomb exposing (..)

import Tile exposing (Spot)
import Time exposing (Time)
import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Bomb =
    { spot : Spot, reach : Int, timestamp : Time }


draw : Bomb -> Svg msg
draw bomb =
    Svg.rect
        [ x (toString (Tuple.first bomb.spot * Tile.size))
        , y (toString (Tuple.second bomb.spot * Tile.size))
        , width "50"
        , height "50"
        , rx "25"
        , ry "25"
        , fill "black"
        ]
        []


splitExploded : Time -> List Bomb -> ( List Bomb, List Bomb )
splitExploded t bombs =
    List.partition (isTimeExceeded t) bombs


isTimeExceeded : Time -> Bomb -> Bool
isTimeExceeded t bomb =
    bomb.timestamp + Time.second * 2.0 < t

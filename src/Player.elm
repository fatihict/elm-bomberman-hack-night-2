module Player exposing (..)

import Tile
import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Player =
    { position : Tile.Spot
    }


draw : Player -> Svg a
draw model =
    Svg.rect
        [ x (toString (Tuple.first model.position * Tile.size))
        , y (toString (Tuple.second model.position * Tile.size))
        , width "50"
        , height "50"
        , fill "red"
        ]
        []


nextSpot : Int -> { a | x : Int, y : Int } -> Player -> Tile.Spot
nextSpot screenWith { x, y } player =
    ( Basics.min (screenWith - 1) <| Basics.max 0 (Tuple.first player.position + x)
    , Basics.min (screenWith - 1) <| Basics.max 0 (Tuple.second player.position - y)
    )

module Tile exposing (..)

import Svg
import Svg.Attributes exposing (fill, width, height, x, y)


type Tile
    = Floor
    | Wall
    | Crate


tileSize : Int
tileSize =
    50


draw : Int -> Int -> Tile -> Svg.Svg msg
draw offsetX offsetY tile =
    Svg.rect
        [ width (toString tileSize)
        , height (toString tileSize)
        , x (toString (offsetX * tileSize))
        , y (toString (offsetY * tileSize))
        , fill "blue"
        ]
        []

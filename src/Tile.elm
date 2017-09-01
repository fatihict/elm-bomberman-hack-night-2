module Tile exposing (..)

import Svg
import Svg.Attributes exposing (..)


type Tile
    = Floor
    | Wall
    | Crate


tileSize : Int
tileSize =
    50


draw : Int -> Int -> Tile -> Svg.Svg msg
draw offsetX offsetY tile =
    case tile of
        Wall ->
            Svg.rect
                [ width (toString tileSize)
                , height (toString tileSize)
                , x (toString (offsetX * tileSize))
                , y (toString (offsetY * tileSize))
                , rx "4"
                , ry "4"
                , fill "black"
                ]
                []

        Crate ->
            Svg.rect
                [ width (toString tileSize)
                , height (toString tileSize)
                , x (toString (offsetX * tileSize))
                , y (toString (offsetY * tileSize))
                , fill "gray"
                ]
                []

        Floor ->
            Svg.rect
                [ width (toString tileSize)
                , height (toString tileSize)
                , x (toString (offsetX * tileSize))
                , y (toString (offsetY * tileSize))
                , fill "salmon"
                ]
                []

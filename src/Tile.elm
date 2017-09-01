module Tile exposing (..)

import Svg
import Svg.Attributes exposing (fill, width, height, x, y, style)


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
                , style "corner-radius: 4px;"
                , fill "black"
                ]
                []

        _ ->
            Svg.rect
                [ width (toString tileSize)
                , height (toString tileSize)
                , x (toString (offsetX * tileSize))
                , y (toString (offsetY * tileSize))
                , fill "blue"
                ]
                []

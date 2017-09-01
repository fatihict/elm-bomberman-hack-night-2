module Tile exposing (..)

import Svg
import Svg.Attributes exposing (..)


type alias Spot =
    ( Int, Int )


type Tile
    = Floor
    | Wall
    | Crate


size : Int
size =
    50


isFloor : Tile -> Bool
isFloor =
    (==) Floor


draw : Int -> Int -> Tile -> Svg.Svg msg
draw offsetX offsetY tile =
    case tile of
        Wall ->
            Svg.rect
                [ width (toString size)
                , height (toString size)
                , x (toString (offsetX * size))
                , y (toString (offsetY * size))
                , rx "4"
                , ry "4"
                , fill "forestgreen"
                ]
                []

        Crate ->
            Svg.rect
                [ width (toString size)
                , height (toString size)
                , x (toString (offsetX * size))
                , y (toString (offsetY * size))
                , fill "gray"
                ]
                []

        Floor ->
            Svg.rect
                [ width (toString size)
                , height (toString size)
                , x (toString (offsetX * size))
                , y (toString (offsetY * size))
                , fill "lightblue"
                ]
                []

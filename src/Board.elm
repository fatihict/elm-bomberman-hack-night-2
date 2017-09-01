module Board exposing (..)

import Array exposing (..)
import Tile exposing (Tile)
import Svg


init : Int -> Int -> Board
init w h =
    Board <|
        Array.initialize
            w
            (\x -> Array.initialize h (\y -> initialTile x y))


initialTile : Int -> Int -> Tile
initialTile x y =
    if x % 2 == 1 && y % 2 == 1 then
        Tile.Wall
    else
        Tile.Floor


type Board
    = Board (Array (Array Tile))


draw : Board -> Svg.Svg msg
draw (Board board) =
    let
        mapTile : Int -> ( Int, Tile ) -> Svg.Svg msg
        mapTile x ( y, t ) =
            Tile.draw x y t

        mapColumn : ( Int, Array Tile ) -> List (Svg.Svg msg) -> List (Svg.Svg msg)
        mapColumn ( x, column ) b =
            List.map (mapTile x) (Array.toIndexedList column) ++ b

        gs : List (Svg.Svg msg)
        gs =
            List.foldl mapColumn [] (Array.toIndexedList board)
    in
        Svg.g []
            gs

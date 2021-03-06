module Board exposing (..)

import Array exposing (..)
import Tile exposing (Tile)
import Svg


type alias BoardInternal =
    Array (Array Tile)


init : Int -> Int -> Board
init w h =
    Array.initialize
        w
        (\x -> Array.initialize h (\y -> initialTile x y))
        |> addCrate 1 0
        |> addCrate 2 1
        |> addCrate 3 2
        |> addCrate 4 3
        |> addCrate 5 4
        |> addCrate 6 5
        |> addCrate 7 6
        |> Board


addCrate : Int -> Int -> BoardInternal -> BoardInternal
addCrate x y matrix =
    Array.get x matrix
        |> Maybe.map (\column -> Array.set y Tile.Crate column |> (\newColumn -> Array.set x newColumn matrix))
        |> Maybe.withDefault matrix


initialTile : Int -> Int -> Tile
initialTile x y =
    if x % 2 == 1 && y % 2 == 1 then
        Tile.Wall
    else
        Tile.Floor


type Board
    = Board (Array (Array Tile))


canMoveToSpot : Tile.Spot -> Board -> Bool
canMoveToSpot ( x, y ) (Board board) =
    Array.get x board
        |> Maybe.andThen (Array.get y)
        |> Maybe.map Tile.isFloor
        |> Maybe.withDefault False


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

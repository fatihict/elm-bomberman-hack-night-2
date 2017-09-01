module Board exposing (..)

import Array exposing (..)
import Tile exposing (Tile)


init : Int -> Int -> Board
init w h =
    Board <|
        Array.initialize
            w
            (\x -> Array.initialize h (\y -> initialTile x y))


initialTile : Int -> Int -> Tile
initialTile x y =
    Tile.Floor


type Board
    = Board (Array (Array Tile))

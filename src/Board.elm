module Board exposing (..)

import Array exposing (..)
import Tile exposing (Tile)


init : Int -> Int -> Board
init w h =
    Board Array.empty


type Board
    = Board (Array (Array Tile))

module Main exposing (..)

import Html exposing (..)
import Keyboard.Extra exposing (Key)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
import Board exposing (Board)
import Player exposing (Player)


type alias Screen =
    { width : Int
    , height : Int
    }


type alias Model =
    { pressedKeys : List Key
    , player : Player
    , screen : Screen
    , currentTime : Time
    , board : Board
    , bombs : List Bomb
    }


type alias Bomb =
    { spot : Spot, reach : Int, timestamp : Time }


type alias Spot =
    ( Int, Int )


type Msg
    = Tick Time
    | KeyMsg Keyboard.Extra.Msg



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model | currentTime = newTime }
            , Cmd.none
            )

        KeyMsg keyMsg ->
            let
                newPressedKeys =
                    Keyboard.Extra.update keyMsg model.pressedKeys

                arrowDirection =
                    Keyboard.Extra.arrows model.pressedKeys
                        |> Debug.log "Arrows"

                player =
                    model.player

                newPosition =
                    Player.nextSpot model.screen.width arrowDirection player

                newPlayer =
                    if Board.canMoveToSpot newPosition model.board then
                        { player | position = newPosition }
                    else
                        player
            in
                ( { model
                    | pressedKeys = newPressedKeys
                    , player = newPlayer
                  }
                , Cmd.none
                )


view : Model -> Html Msg
view model =
    Svg.svg [ width (toString <| model.screen.width * 50), height (toString <| model.screen.height * 50) ]
        [ Board.draw model.board

        -- , player model
        , Player.draw model.player
        ]


subscriptions : Model -> Sub Msg
subscriptions state =
    Sub.batch
        [ Sub.map KeyMsg Keyboard.Extra.subscriptions
        , Time.every second Tick
        ]



-- INIT


init : Float -> ( Model, Cmd Msg )
init seed =
    ( { pressedKeys = []
      , currentTime = 0
      , bombs = [ { spot = ( 2, 2 ), timestamp = seed, reach = 1 } ]
      , player = { position = ( 0, 0 ) }
      , screen =
            { width = 13
            , height = 13
            }
      , board = Board.init 13 13
      }
    , Cmd.none
    )


main : Program Float Model Msg
main =
    Html.programWithFlags
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }

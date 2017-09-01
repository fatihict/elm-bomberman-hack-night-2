module Main exposing (..)

import Html exposing (..)
import Keyboard.Extra exposing (Key)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
import Board exposing (Board)


-- MODEL


type alias Player =
    { x : Int
    , y : Int
    , width : Int
    , height : Int
    }


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
    }


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

                { x, y } =
                    Keyboard.Extra.arrows model.pressedKeys
                        |> Debug.log "Arrows"

                player =
                    model.player

                ( newX, newY ) =
                    ( Basics.min (model.screen.width - 1) <| Basics.max 0 (player.x + x)
                    , Basics.min (model.screen.height - 1) <| Basics.max 0 (player.y - y)
                    )

                newPlayer =
                    if Board.canMoveToSpot newX newY model.board then
                        { player
                            | x = newX
                            , y = newY
                        }
                    else
                        player
            in
                ( { model
                    | pressedKeys = newPressedKeys
                    , player = newPlayer
                  }
                , Cmd.none
                )



-- VIEW


player : Model -> Html Msg
player model =
    Svg.rect [ x (toString (model.player.x * model.player.width)), y (toString (model.player.y * model.player.height)), width "50", height "50", fill "red" ] []


view : Model -> Html Msg
view model =
    Svg.svg [ width (toString <| model.screen.width * 50), height (toString <| model.screen.height * 50) ]
        [ Board.draw model.board
        , player model
        ]


subscriptions : Model -> Sub Msg
subscriptions state =
    Sub.batch
        [ Sub.map KeyMsg Keyboard.Extra.subscriptions

        -- Time.every second Tick
        ]



-- INIT


init : Float -> ( Model, Cmd Msg )
init seed =
    ( { pressedKeys = []
      , currentTime = 0
      , player =
            { x = 0
            , y = 0
            , width = 50
            , height = 50
            }
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

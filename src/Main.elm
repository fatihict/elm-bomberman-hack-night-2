module Main exposing (..)

import Html exposing (..)
import Keyboard.Extra exposing (Key)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
import Board


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

                newPlayer =
                    model.player
                        |> (\p ->
                                { p
                                    | x = Basics.min (model.screen.width - p.width) <| Basics.max 0 (p.x + x * 50)
                                    , y = Basics.min (model.screen.height - p.height) <| Basics.max 0 (p.y - y * 50)
                                }
                           )
            in
                ( { model
                    | pressedKeys = newPressedKeys
                    , player = newPlayer
                  }
                , Cmd.none
                )



-- VIEW


player : Player -> Html Msg
player player =
    Svg.rect [ x (toString player.x), y (toString player.y), width "50", height "50", fill "red" ] []


view : Model -> Html Msg
view model =
    Svg.svg [ width (toString model.screen.width), height (toString model.screen.height) ]
        [ Svg.rect [ width "650", height "650", fill "darksalmon" ] []
        , Board.draw (Board.init 13 13)
        , player model.player
        ]


subscriptions : Model -> Sub Msg
subscriptions state =
    Sub.batch
        [ Sub.map KeyMsg Keyboard.Extra.subscriptions

        -- Time.every second Tick
        ]



-- INIT


init : ( Model, Cmd Msg )
init =
    ( { pressedKeys = []
      , currentTime = 0
      , player =
            { x = 0
            , y = 0
            , width = 50
            , height = 50
            }
      , screen =
            { width = 650
            , height = 650
            }
      }
    , Cmd.none
    )


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }

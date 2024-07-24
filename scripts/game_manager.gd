class_name GameManager extends Node

@export var api: TicTacToeAPI;

var _player_turn: TicTacToeAPI.PlayerTurn;
var _current_game_state: TicTacToeAPI.GameState;

signal on_game_data_changed(Vector2i);
signal on_game_won(int);
signal on_game_drawn();

func _ready() -> void:
    _player_turn = TicTacToeAPI.PlayerTurn.X;
    _current_game_state = TicTacToeAPI.GameState.Going;

func player_pressed(coords: Vector2i) -> void:
    if _current_game_state != TicTacToeAPI.GameState.Going:
        return;
    
    var data = api.get_game_data_at_coords(coords);
    
    if data != 0:
        return;
        
    api.set_game_data_at_coords(int(_player_turn), coords);
    on_game_data_changed.emit(coords)

    _current_game_state = api.check_game_state();

    if _current_game_state == TicTacToeAPI.GameState.Won:
        win_game();
        return;
    elif _current_game_state== TicTacToeAPI.GameState.Drawn:
        drawn_game();
        return;
    # -------------------
    _switch_turn();

func get_win_pattern() -> Array:
    return api.get_win_pattern();

func win_game():
    print(_player_turn, " Win the game")
    on_game_won.emit(int(_player_turn));

func drawn_game():
    print("Both drawn the game");
    on_game_drawn.emit();
    

func _switch_turn():
    if _player_turn == TicTacToeAPI.PlayerTurn.X:
        _player_turn = TicTacToeAPI.PlayerTurn.O;
    else:
        _player_turn = TicTacToeAPI.PlayerTurn.X;
        
    
        
            
            
    

class_name GameManager extends Node

var player_turn: TicTacToeAPI.PlayerTurn;

var x_moves_data: Array[Vector2i];
var o_moves_data: Array[Vector2i];

var _is_won: bool = false;

@export var tic_tac_toe_api: TicTacToeAPI;

signal on_game_data_changed(Vector2i);
signal on_data_will_remove_this_move(Vector2i);
signal on_game_won(int);


func _ready() -> void:
    player_turn = TicTacToeAPI.PlayerTurn.X;

func player_pressed(coords: Vector2i) -> void:
    if _is_won:
        return;
    
    var data = tic_tac_toe_api.get_game_data_at_coords(coords);
    
    if data != 0:
        return;
        
    tic_tac_toe_api.set_game_data_at_coords(int(player_turn), coords);
    on_game_data_changed.emit(coords)
    # -----------------
    if player_turn == TicTacToeAPI.PlayerTurn.X:
        x_moves_data.append(coords);
    else:
        o_moves_data.append(coords);
    
    _remove_move_data();

    # ---------------
    _is_won = tic_tac_toe_api.check_win();
    if _is_won:
        win_game();
        return;
    # -------------------
    _switch_turn();
    _check_will_remove_data();

func get_win_pattern() -> Array:
    return tic_tac_toe_api.get_win_pattern();

func win_game():
    print(player_turn, " Win the game")
    on_game_won.emit(int(player_turn));

func _remove_move_data():
    if player_turn == TicTacToeAPI.PlayerTurn.X:
        
        if len(x_moves_data) > 3:
            var coords: Vector2i = x_moves_data.pop_at(0);
            tic_tac_toe_api.set_game_data_at_coords(0, coords);
            on_game_data_changed.emit(coords);
    else:
        if len(o_moves_data) > 3:
            var coords: Vector2i = o_moves_data.pop_at(0);
            tic_tac_toe_api.set_game_data_at_coords(0, coords);
            on_game_data_changed.emit(coords);

func _check_will_remove_data():
    if player_turn == TicTacToeAPI.PlayerTurn.X && len(x_moves_data) == 3:
        on_data_will_remove_this_move.emit(x_moves_data[0])
    elif player_turn == TicTacToeAPI.PlayerTurn.O && len(o_moves_data) == 3:
        on_data_will_remove_this_move.emit(o_moves_data[0])
    

func _switch_turn():
    if player_turn == TicTacToeAPI.PlayerTurn.X:
        player_turn = TicTacToeAPI.PlayerTurn.O;
    else:
        player_turn = TicTacToeAPI.PlayerTurn.X;
        
    
        
            
            
    

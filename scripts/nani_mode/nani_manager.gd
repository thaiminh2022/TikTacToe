class_name NaniManager extends GameManager 


var x_moves_data: Array[Vector2i];
var o_moves_data: Array[Vector2i];



signal on_data_will_remove_this_move(Vector2i);

func player_pressed(coords: Vector2i) -> void:
    if _current_game_state != TicTacToeAPI.GameState.Going:
        return;
    
    var data = api.get_game_data_at_coords(coords);
    
    if data != 0:
        return;
        
    api.set_game_data_at_coords(int(_player_turn), coords);
    on_game_data_changed.emit(coords)
    # -----------------
    if _player_turn == TicTacToeAPI.PlayerTurn.X:
        x_moves_data.append(coords);
    else:
        o_moves_data.append(coords);
    
    _remove_move_data();

    # ---------------
    _current_game_state = api.check_game_state();
    if _current_game_state == TicTacToeAPI.GameState.Won: 
        win_game();
        return;
    # -------------------
    _switch_turn();
    _check_will_remove_data();


func _remove_move_data():
    if _player_turn == TicTacToeAPI.PlayerTurn.X:
        
        if len(x_moves_data) > 3:
            var coords: Vector2i = x_moves_data.pop_at(0);
            api.set_game_data_at_coords(0, coords);
            on_game_data_changed.emit(coords);
    else:
        if len(o_moves_data) > 3:
            var coords: Vector2i = o_moves_data.pop_at(0);
            api.set_game_data_at_coords(0, coords);
            on_game_data_changed.emit(coords);

func _check_will_remove_data():
    if _player_turn == TicTacToeAPI.PlayerTurn.X && len(x_moves_data) == 3:
        on_data_will_remove_this_move.emit(x_moves_data[0])
    elif _player_turn == TicTacToeAPI.PlayerTurn.O && len(o_moves_data) == 3:
        on_data_will_remove_this_move.emit(o_moves_data[0])
 

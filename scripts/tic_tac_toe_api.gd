class_name TicTacToeAPI extends Node

enum PlayerTurn { 
    X = 1,
    O = 2
}

# 00 -> none
# 1 -> X player
# 2 -> O player
var _game_data := {
    Vector2i(0, 0): 0,
    Vector2i(1, 0): 0,
    Vector2i(2, 0): 0,
    Vector2i(0, 1): 0,
    Vector2i(1, 1): 0,
    Vector2i(2, 1): 0,
    Vector2i(0, 2): 0,
    Vector2i(1, 2): 0,
    Vector2i(2, 2): 0,
}

var _patterns:=  [
# Horizontal
   [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0)],
   [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)],
   [Vector2i(0, 2), Vector2i(1, 2), Vector2i(2, 2)],
# Vertical
   [Vector2i(0, 0), Vector2i(0, 1), Vector2i(0, 2)],
   [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2)],
   [Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 2)],

# Diagonal
   [Vector2i(0, 0), Vector2i(1, 1), Vector2i(2, 2)],
   [Vector2i(2, 0), Vector2i(1, 1), Vector2i(0, 2)],
]

var _win_pattern: Array = [];

func get_game_data_at_coords(coords: Vector2i) -> int:
    return _game_data[coords];

func set_game_data_at_coords(data: int, coords: Vector2i):
    _game_data[coords] = data;

func check_win() -> bool:
    var found_match = false;
    
    for pattern in _patterns:
        var start_value: int = _game_data[pattern[0]];
        
        # This tile has not been set
        if (start_value ==0 ):
            continue;
        
        found_match = true;
        
        for coord in pattern:
            var coord_value: int = _game_data[coord];
            if start_value != coord_value:
                found_match = false;
                break;
                
        if found_match == true:
            _win_pattern = pattern;
            return found_match
    return found_match;

func get_win_pattern() -> Array:
    return _win_pattern;

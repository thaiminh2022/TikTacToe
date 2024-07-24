extends MarginContainer

@export var game_manager: GameManager;
@export var tictactoe_visual: TicTacToeDisplay;


func _ready() -> void:
    game_manager.on_data_will_remove_this_move.connect(_data_remove_this_move)

func _data_remove_this_move(coords: Vector2i):
    var subject_btn := tictactoe_visual.find_grid_btns_same_coords(coords);

    if subject_btn == null:
        return;

    subject_btn.set_preremove();


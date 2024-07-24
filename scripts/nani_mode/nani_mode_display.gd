extends MarginContainer

@export var game_manager: GameManager;
@export var grid_buttons: Array[GridButton]


func _ready() -> void:
    game_manager.on_data_will_remove_this_move.connect(_data_remove_this_move)

func _data_remove_this_move(coords: Vector2i):
    var subject_btn := _find_grid_btns_same_coords(coords);

    if subject_btn == null:
        return;

    subject_btn.set_preremove();

func _find_grid_btns_same_coords(coords: Vector2i) -> GridButton:
    for btn in grid_buttons:
        if btn.coords == coords:
            return btn;

    return null;



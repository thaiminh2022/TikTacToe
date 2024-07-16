extends Control


@export var game_manager: GameManager;
@export var grid_buttons: Array[GridButton]
@export var line: Line2D;

@export var exit_btn: Button;

func _ready() -> void:
    game_manager.on_game_data_changed.connect(_game_data_changed)
    game_manager.on_data_will_remove_this_move.connect(_data_remove_this_move)
    game_manager.on_game_won.connect(draw_win_line);
    for grid_btn in grid_buttons:
        grid_btn.pressed.connect(func(): _on_grid_btn_pressed(grid_btn))
    
    exit_btn.pressed.connect(func(): SceneManager.load_scene(SceneManager.Scenes.MainMenu));
        
func _on_grid_btn_pressed(btn: GridButton):
    game_manager.player_pressed(btn.coords);

func _game_data_changed(coords: Vector2i):
    var data := game_manager.tic_tac_toe_api.get_game_data_at_coords(coords);
    
    # 1-> x
    # 2 -> o
    # 0 -> None
    var subject_btn = _find_grid_btns_same_coords(coords);
    
    if subject_btn == null:
        print("subject is null")
        return;
    
    if data == 0:
        subject_btn.clear_texture();
    elif data == 1:
        subject_btn.set_x_color().set_x_texture();
    else:
        subject_btn.set_o_color().set_o_texture();
        
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
    
func draw_win_line(_turn: int) -> void:
    var win_pattern = game_manager.get_win_pattern();
    var start = win_pattern[0];
    var end = win_pattern[len(win_pattern) -1];
    
    var subject_btn := grid_buttons[0];
    var btn_size := subject_btn.size.x;
    var offset := 30
    var line_offset := Vector2i(line.width / 4, line.width / 4);
    
    var vec_offset = Vector2i(offset, offset) + Vector2i(btn_size, btn_size)/2
    
    line.points = [
        vec_offset + Vector2i(start.x * btn_size, start.y * btn_size) + line_offset,
        vec_offset + Vector2i(end.x * btn_size, end.y * btn_size)+line_offset,
    ]
        
    
    
    
        
    

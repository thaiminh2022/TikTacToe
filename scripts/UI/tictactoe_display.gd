class_name TicTacToeDisplay extends Control

@export var game_manager: GameManager;
@export var grid_btns_parent : GridContainer;
@export var line: Line2D;
@export var exit_btn: Button;

var _grid_buttons: Array[GridButton]

func _ready() -> void:
    game_manager.on_game_data_changed.connect(_game_data_changed)
    game_manager.on_game_won.connect(draw_win_line);

    for child in grid_btns_parent.get_children():
        _grid_buttons.append(child as GridButton);


    for grid_btn in _grid_buttons:
        grid_btn.pressed.connect(func(): _on_grid_btn_pressed(grid_btn))
    
    exit_btn.pressed.connect(func(): SceneManager.load_scene(SceneManager.Scenes.MainMenu));
        
func _on_grid_btn_pressed(btn: GridButton):
    game_manager.player_pressed(btn.coords);

func _game_data_changed(coords: Vector2i):
    var data := game_manager.api.get_game_data_at_coords(coords);
    
    # 1-> x
    # 2 -> o
    # 0 -> None
    var subject_btn = find_grid_btns_same_coords(coords);
    
    if subject_btn == null:
        print("subject is null")
        return;
    
    if data == 0:
        subject_btn.clear_texture();
    elif data == 1:
        subject_btn.set_x_color().set_x_texture();
    else:
        subject_btn.set_o_color().set_o_texture();
        

func find_grid_btns_same_coords(coords: Vector2i) -> GridButton:
    for btn in _grid_buttons:
        if btn.coords == coords:
            return btn;
            
    return null;
    
func draw_win_line(_turn: int) -> void:
    var win_pattern = game_manager.get_win_pattern();
    var start_pos = win_pattern[0];
    var end_pos = win_pattern[len(win_pattern) -1];
    var btn_size = _grid_buttons[0].size;

    var start_btn := find_grid_btns_same_coords(start_pos);
    var end_btn := find_grid_btns_same_coords(end_pos);

    var start_local = start_btn.get_global_transform_with_canvas().origin + btn_size / 2;
    var end_local = end_btn.get_global_transform_with_canvas().origin + btn_size / 2;
	
    line.points = [
        start_local,
        end_local,

            ]
        
   

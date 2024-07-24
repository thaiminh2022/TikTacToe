extends MarginContainer

@export var game_manager:GameManager;

@export var x_texture: TextureRect;
@export var o_texture: TextureRect;

var game_finished: bool =false;

func _ready() -> void:
    game_manager.on_game_data_changed.connect(data_change);
    game_manager.on_game_won.connect(func(_turn): game_finished =true)
    
func data_change(coords: Vector2i):
    if game_finished:
        return;
    
    var data := game_manager.api.get_game_data_at_coords(coords);
    
    
    if data == TicTacToeAPI.PlayerTurn.X:
        x_texture.modulate = Color(x_texture.modulate, .5);
        o_texture.modulate = Color(o_texture.modulate, 1);
    elif data == TicTacToeAPI.PlayerTurn.O:
        x_texture.modulate = Color(x_texture.modulate, 1);
        o_texture.modulate = Color(o_texture.modulate, .5);
        
        

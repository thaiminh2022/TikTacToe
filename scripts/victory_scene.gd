extends Control

@export var delay_timer: Timer;
@export var game_manager: GameManager;

@export var x_texture: Texture2D;
@export_color_no_alpha var x_color: Color;
@export var o_texture: Texture2D;
@export_color_no_alpha var o_color: Color;

@export var texture_rect: TextureRect;
@export var restart_btn: Button;
var player_turn: TicTacToeAPI.PlayerTurn;

func _ready() -> void:
    hide();
    
    game_manager.on_game_won.connect(func(p_turn): 
        player_turn = p_turn;
        delay_timer.start());
        
    delay_timer.timeout.connect(game_won)
    restart_btn.pressed.connect(SceneManager.restart_scene);
    

func game_won():
    show();
    
    if player_turn == TicTacToeAPI.PlayerTurn.X:
        texture_rect.texture = x_texture;
        texture_rect.modulate = x_color;
    elif player_turn == TicTacToeAPI.PlayerTurn.O:
        texture_rect.texture = o_texture;
        texture_rect.modulate = o_color;
        
    
    

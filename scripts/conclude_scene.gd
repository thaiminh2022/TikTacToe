extends Control

@export var delay_timer: Timer;
@export var game_manager: GameManager;

@export var x_display: TextureRect;
@export var o_display: TextureRect;
@export var message_label: Label;

@export var restart_btn: Button;

var is_won := false;
var player_turn: TicTacToeAPI.PlayerTurn;

func _ready() -> void:
    hide();
    
    game_manager.on_game_won.connect(func(p_turn): 
        player_turn = p_turn;
        is_won = true;
        delay_timer.start());
        
    game_manager.on_game_drawn.connect(func():
        is_won =false;
        delay_timer.start())

    delay_timer.timeout.connect(game_concluded)
    restart_btn.pressed.connect(SceneManager.restart_scene);
    

func game_concluded():
    show();
    
    if is_won:
        if player_turn == TicTacToeAPI.PlayerTurn.X:
            x_display.show();
            o_display.hide();
        elif player_turn == TicTacToeAPI.PlayerTurn.O:
            x_display.hide();
            o_display.show();

        message_label.text = "WIN THE GAME";
    else:
        x_display.show();
        o_display.show();
        message_label.text = "DRAWN!!!";
    
    

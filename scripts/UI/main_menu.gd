extends Control

@export_group("Menu")
@export var start_btn: Button;
@export var credits_btn: Button;
@export var exit_btn: Button;

@export_group("Choose a Gamemode")
@export var choose_a_gamemode: Control;
@export var hide_gamemode_btn: Button;

@export var normal_mode_btn: Button;
@export var nani_mode_btn: Button;
@export var dimensional_mode_btn: Button;


@export_group("Credits")
@export var credits_scene: Control;
@export var hide_credits_btn: Button

func _ready() -> void:
    start_btn.pressed.connect(choose_a_gamemode.show)
    hide_gamemode_btn.pressed.connect(choose_a_gamemode.hide)
    credits_btn.pressed.connect(credits_scene.show);
    hide_credits_btn.pressed.connect(credits_scene.hide);
    
    exit_btn.pressed.connect(get_tree().quit);
    
    normal_mode_btn.pressed.connect(func(): switch_scene(1));
    nani_mode_btn.pressed.connect(func(): switch_scene(2));
    dimensional_mode_btn.pressed.connect(func(): switch_scene(3));
    
    
func switch_scene(scene_index: int):
    SceneManager.load_scene(scene_index);

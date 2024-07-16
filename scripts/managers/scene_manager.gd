extends Node

@export var scenes: Array[PackedScene];

enum Scenes {
    MainMenu,
    NormalTicTacToe,
    NaniTicTacToe,
    DimensionalTicTacToe
}

func load_scene(scene: Scenes):
    var scene_index := int(scene);
    
    if scene_index >= len(scenes):
        return;
    
    get_tree().change_scene_to_packed(scenes[scene_index]);


func restart_scene():
    get_tree().reload_current_scene();

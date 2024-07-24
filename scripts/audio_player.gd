extends AudioStreamPlayer

@export var game_manager:GameManager 

@export var x_move_audio:AudioStream;
@export var o_move_audio:AudioStream;


func _ready() -> void:
    game_manager.on_game_data_changed.connect(play_sound)
    
func play_sound(coords: Vector2i):
    var game_data := game_manager.api.get_game_data_at_coords(coords)
    
    if game_data == 0:
        return;
    
    if game_data ==1:
        # x_move
        play_stream(x_move_audio);
    else:
        play_stream(o_move_audio)


func play_stream(audio_stream: AudioStream):
    stream = audio_stream
    playing = true;
        

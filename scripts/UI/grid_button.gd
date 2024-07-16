class_name GridButton extends Button

@export_category("Game data")
@export var coords: Vector2i;
@export var texture_rect: TextureRect;

@export_category("Visual data")
@export_color_no_alpha var x_color: Color;
@export_color_no_alpha var o_color: Color;

@export var x_texture: Texture2D;
@export var o_texture: Texture2D;

func set_preremove() -> GridButton:
    print("Set pre remove: ", coords)
    texture_rect.modulate = Color(texture_rect.modulate, .5) 
    return self;

func set_x_color() -> GridButton:
    texture_rect.modulate = x_color;
    return self;
    
func set_o_color()-> GridButton:
    texture_rect.modulate = o_color;
    return self;

func set_x_texture()-> GridButton:
    texture_rect.texture = x_texture;
    return self;
    
func set_o_texture()-> GridButton:
    texture_rect.texture = o_texture;
    return self;

func clear_texture() -> GridButton:
    texture_rect.texture = null;
    return self;
    

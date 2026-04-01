extends Control

export (Array, Texture) var textures
var pressed : bool = false
signal button_pressed 
"""Este codigo tiene 2 texturas de exportacion, la 1ra es normal y la 2da boton apretado 
Se crea la animacion automaticamente, se cambia pivot y alterna entre un estado y el otro"""

func _ready():
	$TextureRect.texture = textures[0]
	$TextureRect.rect_position = -textures[0].get_size() / 2 
	$TextureRect.rect_pivot_offset = textures[0].get_size() / 2 

func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		$AnimationPlayer.play("anim_button")

func change_texture():
	pressed = !pressed
	$TextureRect.texture = textures[1] if pressed else textures[0]
	emit_signal("button_pressed")

extends Control
#Texturas como variable de exportacion, donde la 1ra debe ser modo normal y la 2da modo presionado
export (Array, Texture) var texture

func _ready():
#Pongo la 1er textura como normal y ajusto el pivote al centro (es dinamico para cada tamaño)
	$TextureButton.texture_normal = texture[0]

func change_texture():
	if $TextureButton.pressed:
		$TextureButton.texture_normal = texture[1] #Ahora esta apagado
	else:
		$TextureButton.texture_normal = texture[0] #Ahora esta encendido

func _on_TextureButton_pressed():
	$TextureButton.rect_pivot_offset = $TextureButton.rect_size / 2 
	$AnimationPlayer.play("anim_button")

extends Control

var decreasing = 1

func _physics_process(_delta):
	if $TextureProgress.value == 100:
		decreasing = 1
	if $TextureProgress.value == 0:
		decreasing = 0
	
	if decreasing:
		$TextureProgress.value -= 1
		$TextureProgressRadial.value -= 1
	else:
		$TextureProgress.value += 1
		$TextureProgressRadial.value += 1
	


func _on_Button_button_pressed():
	if $VBoxContainer/Button.pressed:
		$Audio.play()
	else:
		$Audio.stop()


func _on_Button2_button_pressed():
	if $VBoxContainer/Button2.pressed:
		$Audio2.play()
	else:
		$Audio2.stop()

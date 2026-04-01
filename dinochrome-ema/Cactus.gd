extends Area2D

func _physics_process(_delta):
	position.x -= state.speed

func _cactus_screen_exited():
	queue_free()

func _on_Cactus_area_entered(area):
	state.dino_state = state.S.dead

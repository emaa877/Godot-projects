extends Area2D

func _physics_process(_delta):
	position.x -= state.speed

func _pterodac_screen_exited():
	queue_free()

func _on_Pterodac_area_entered(area):
	state.dino_state = state.S.dead

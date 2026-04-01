extends Sprite

func _physics_process(_delta):
	position.x -= state.speed

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

extends CharacterBody2D

const SPEED = 70
var movedir := Vector2.ZERO
var movedir_old := Vector2.ZERO

func _physics_process(delta):
	controls_loop()
	movement_loop()

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	movedir.x = int(RIGHT) - int(LEFT)
	movedir.y = int(DOWN) - int(UP)
	switch_anim()
	movedir_old = movedir
	
func movement_loop():
	movedir = movedir.normalized() * SPEED
	set_velocity(movedir)
	set_up_direction(Vector2.ZERO)
	move_and_slide()
	movedir = velocity

func switch_anim():
	$AnimatedSprite2D.flip_h = false
	match movedir:
		dir.CENTER:
			if movedir_old == dir.UP:
				$AnimatedSprite2D.animation = "stop_up"
			elif movedir_old == dir.DOWN:
				$AnimatedSprite2D.animation = "stop_down"
			elif movedir_old == dir.LEFT:
				$AnimatedSprite2D.animation = "stop_left"
			elif movedir_old == dir.RIGHT:
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.animation = "stop_left"
		dir.UP:  
			$AnimatedSprite2D.animation = "up"
		dir.DOWN:
			$AnimatedSprite2D.animation = "down"
		dir.LEFT:
			$AnimatedSprite2D.animation = "left"
		dir.RIGHT:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.animation = "left"

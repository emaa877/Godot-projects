extends KinematicBody2D
var jump_sound = preload("res://Sounds/Mario_Jump.wav")
var score_sound = preload("res://Sounds/Game_Boy_Pause.wav")
export (int) var jump_speed = -800
export (int) var gravity = 1700
var velocity = Vector2()
var jumping = false
var ducking = false

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	
	if is_on_floor() and (!jumping and !ducking) and state.dino_last_state != state.S.running:
		state.dino_state = state.S.running
		$AnimatedSprite.animation = 'run'
		if state.dino_last_state == state.S.ducking:
			duck_animation_fix()
	if ducking and state.dino_last_state != state.S.ducking:
		state.dino_state = state.S.ducking
		$AnimatedSprite.animation = 'duck'
		run_animation_fix()
	if jumping:
		state.dino_state = state.S.jumping
		$AnimatedSprite.animation = 'jump'
		$Audio.stream = jump_sound
		$Audio.playing = true
	if state.score%100 == 0 and state.score != 0:
		$Audio.stream = score_sound
		$Audio.playing = true
	if state.dino_state == state.S.jumping:
		rotate(-6.428*PI/180)
	if abs(rotation_degrees - 360) < 1:
		rotation_degrees=0
	#actualizacion de variables
	state.dino_last_state = state.dino_state
	if jumping and is_on_floor():
		jumping = false
	if ducking and Input.is_action_just_released('ui_down'):
		ducking = false
	
	velocity = move_and_slide(velocity,Vector2(0,-1))

func run_animation_fix():
	$Area2D/Collision.position.x = 7
	$Area2D/Collision.position.y = 12
	$Area2D/Collision.rotate(60*PI/180)
	$Area2D/Collision.scale.x = 1.2
	$AnimatedSprite.position.y = 12.5

func duck_animation_fix():
	$Area2D/Collision.position.x = 13.7
	$Area2D/Collision.position.y = -5.3
	$Area2D/Collision.rotate(-60*PI/180)
	$Area2D/Collision.scale.x = 1
	$AnimatedSprite.position.y = 0

func get_input():
	velocity.x = 0
	var jump = Input.is_action_just_pressed('ui_select')
	var duck = Input.is_action_pressed('ui_down')
	if jump and is_on_floor() and !duck:
		jumping = true
		velocity.y = jump_speed
	if duck and is_on_floor():
		ducking = true

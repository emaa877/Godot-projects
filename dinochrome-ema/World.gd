extends Node2D
var cactus = preload("res://Cactus.tscn")
var pterodac = preload("res://Pterodac.tscn")
var cloud = preload("res://Cloud.tscn")
var stone = preload("res://Stone.tscn")
var dead_sound = preload("res://Sounds/Rick_and_morty.wav")
var enemy
var count = 0

func _ready():
	randomize()
	state.game_state = state.G.INITIAL
	new_game()
	state.game_state = state.G.PLAYING

func _physics_process(delta):
	count += 1
	if state.dino_state == state.S.dead:
		game_over()
	if count > randi()%150+75+250 * delta:
		count = 0
		new_enemy()

func new_game():
	state.score = 0
	
	$CanvasLayer/GameOver.visible = false #game over
	$CanvasLayer/TextureButton.visible = false #boton de reiniciar
	#$Pterodac.queue_free()
	#$Cactus.queue_free()
	
func game_over():
	state.dino_state = state.S.dead
	state.game_state = state.G.PAUSE
	$Dino/AnimatedSprite.animation = 'dead'
	#$CloudTimer.stop()
	#yield(get_tree(), "physics_frame")
	#yield(VisualServer, 'frame_pre_draw')
	yield(VisualServer, 'frame_post_draw')
	get_tree().paused = true

func new_enemy():
	enemy = randi()%10
	if enemy > 3:
		var cactus_new = cactus.instance()
		cactus_new.position = Vector2(1050,361)
		cactus_new.add_user_signal("golpe")
		add_child(cactus_new)
	else:
		var new_pterodac = pterodac.instance()
		if randi()%2:
			new_pterodac.position = Vector2(1080,230)
		else:
			new_pterodac.position = Vector2(1080,340)
		add_child(new_pterodac)

func _on_CloudTimer_timeout():
	add_child(cloud.instance())
	$CloudTimer.wait_time = rand_range(1,3)

func _on_StoneTimer_timeout():
	var new_stone = stone.instance()
	var pos_y = int(rand_range(420,450))
	new_stone.position = Vector2(1030,pos_y)
	var x = randi()%4+1
	var stone_number = 'stone' + str(x)
	new_stone.animation = stone_number
	add_child(new_stone)

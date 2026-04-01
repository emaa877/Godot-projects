extends CanvasLayer
var score_text = ""
var highscore := 0
signal button_pressed

func _ready():
	var hi_file = int(_load())
	if hi_file:
		highscore = hi_file
		_update_score(highscore)
		$Score/Highscore.text = "HI " + score_text
		$Score/Highscore.show()

func _physics_process(_delta):
	if state.dino_state == state.S.dead:
		$GameOver.show() #game over
		$TextureButton.show() #boton de reiniciar
		$Score/Timer.stop()
		if state.score > highscore:
			highscore = state.score 
			$Score/Highscore.text = "HI " + score_text
			save(str(highscore))

func _update_score(s):
	if s < 10:
		score_text = "0000" + str(s)
	elif s < 100:
		score_text = "000" + str(s)
	elif s < 1000:
		score_text = "00" + str(s)
	elif s < 10000:
		score_text = "0" + str(s)
	elif s >= 10000:
		score_text = str(s)
	if s % 150 == 0: #cada 150 puntos aumenta la velocidad de puntos
		$Score/Timer.wait_time -= 0.02

func _on_Timer_timeout():
	state.score += 1
	_update_score(state.score)
	$Score.text = score_text #esta linea de codigo esta fuera de update score
	#porque la utilizo en actualizar el highscore al principio

func _on_TextureButton_pressed():
	state.game_state = state.G.PLAYING
	state.dino_last_state = state.S.running
	get_tree().paused = false
	#get_tree().reload_current_scene()

func save(content):
	var file = File.new()
	file.open("res://save_game.dat", File.WRITE)
	file.store_string(content)
	file.close()

func _load():
	var file = File.new()
	file.open("res://save_game.dat", File.READ)
	var content = file.get_as_text()
	file.close()
	return content

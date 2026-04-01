extends Node

enum S {running,jumping,ducking,dead}
enum G {INITIAL,PLAYING,PAUSE}
var game_state = G.INITIAL
var dino_state = S.running #running jumping ducking dead
var dino_last_state
var speed = 3
var score := 0

func _physics_process(delta):
	speed += delta/5

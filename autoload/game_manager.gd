extends Node

var lives : int
var wave : int
var top_wave : int = 30
var money : int 

func _ready() -> void:
	start_game()

func start_game() -> void:
	lives = 30
	wave = 1
	money = 500
	
func new_wave() -> bool: 
	if wave >= top_wave:
		return false

	wave += 1
	return true

extends Node

var lives : int
var wave : int
var top_wave : int = 30
var money : int 
var elapsed_time := 0.0

func _ready() -> void:
	start_game()

func start_game() -> void:
	lives = 30
	wave = 0
	money = 500
	
	
func new_wave() -> bool: 
	if wave >= top_wave:
		return false

	wave += 1
	return true
	
func _process(delta: float) -> void:
	elapsed_time += delta

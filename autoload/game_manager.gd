extends Node

var lives : int
var wave : int
var top_wave : int = 30
var money : int 
var elapsed_time := 0.0
var g_over : bool = true
signal is_game_over
signal update_lives

func _ready() -> void:
	start_game()

func start_game() -> void:
	lives = 50
	wave = 0
	money = 500
	g_over = false
	
func new_wave() -> bool: 
	if wave >= top_wave:
		return false

	wave += 1
	return true
	
func _process(delta: float) -> void:
	elapsed_time += delta

func game_over() -> void:
	print("GAME OVER")
	g_over = true
	is_game_over.emit()

func subtract_lives(_hp) -> void:
	lives = max(lives - _hp, 0)
	
	if lives == 0 :
		game_over()
		
	update_lives.emit()
	

extends Node
class_name Main

var m_generator : MapGenerator 
var wave_in_progress = false
@onready var background: TileMapLayer = $scenary/background
@onready var path_layer: TileMapLayer = $scenary/path
@export var b_scene : PackedScene
@onready var b_node: Node2D = $ballons
@onready var wave_timer: Timer = $WaveTimer

func _ready() -> void:
	m_generator = MapGenerator.new()
	m_generator._setup(path_layer,b_scene,b_node,Vector2i(-2,2),Vector2i(37,12))
	wave_timer.start()
	wave_in_progress = true

func _on_wave_timer_timeout() -> void:
	create_wave()
	wave_timer.stop()
	
func create_wave():
	if GameManager.new_wave():
		m_generator.spawn_ballons(30)
	
#func _process(delta: float) -> void:
	#print(wave_timer.time_left)
	#pass

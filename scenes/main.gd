extends Node
class_name Main

var m_generator : MapGenerator 
var wave_in_progress : bool = false
@onready var background: TileMapLayer = $scenary/background
@onready var path_layer: TileMapLayer = $scenary/path
@export var b_scene : PackedScene
@onready var b_node: Node2D = $ballons
@onready var wave_timer: Timer = $WaveTimer
@onready var gui: GuiLabel = $CanvasLayer/GUI
var t_catalog = TurretCatalog.new()

func _ready() -> void:
	m_generator = MapGenerator.new()
	m_generator._setup(path_layer,b_scene,b_node,Vector2i(-2,2),Vector2i(35,12))
	GameManager.is_game_over.connect(_on_game_over)
	GameManager.update_lives.connect(u_lives)
	wave_in_progress = false
	wave_timer.start()
	gui.setup(GameManager.wave,GameManager.lives,GameManager.money,t_catalog.basic_catalog)

func _on_wave_timer_timeout() -> void:
	wave_timer.stop()
	#await create_wave()
	
func create_wave():
	print(GameManager.wave)
	if GameManager.g_over or wave_in_progress or not GameManager.new_wave():
		return
		
	wave_in_progress = true
	gui.set_wave(GameManager.wave)
		
	await m_generator.spawn_ballons(30)

	while b_node.get_child_count() > 0:
		await get_tree().create_timer(3.0).timeout
		
	wave_in_progress = false

	if GameManager.wave < GameManager.top_wave:
		wave_timer.start()
		
func u_lives()->void:
	gui.set_lives(GameManager.lives)
			
func _on_game_over() -> void:
	wave_in_progress = false
	wave_timer.stop()
	get_tree().paused = true
			
func _process(delta: float) -> void:
	gui.set_time(GameManager.elapsed_time)

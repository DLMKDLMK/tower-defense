extends Node
class_name Main

var m_generator : MapGenerator 
var b_catalog : BalloonCatalog
var w_catalog : WaveCatalog

var auto_wave : bool = false
var wave_in_progress : bool = false
@onready var background: TileMapLayer = $scenary/background
@onready var path_layer: TileMapLayer = $scenary/path
@export var b_scene : PackedScene
@onready var b_node: Node2D = $ballons
@onready var wave_timer: Timer = $WaveTimer
@onready var gui: GuiLabel = $CanvasLayer/GUI
var t_catalog = TurretCatalog.new()
var selected_turret: TurretDefinition

func _ready() -> void:
	w_catalog = WaveCatalog.new()
	b_catalog = BalloonCatalog.new()
	m_generator = MapGenerator.new()
	m_generator._setup(path_layer,b_scene,b_node,Vector2i(-2,2),Vector2i(35,12))
	GameManager.is_game_over.connect(_on_game_over)
	GameManager.update_lives.connect(u_lives)
	GameManager.update_money.connect(u_money)
	
	wave_in_progress = false
	
	gui.setup(GameManager.wave,GameManager.lives,GameManager.money,t_catalog.basic_catalog)
	gui.turret_selected.connect(_on_turret_selected)
	gui.auto_wave_on.connect(f_auto_wave)

func _on_turret_selected(definition: TurretDefinition) -> void:
	selected_turret = definition
	print("Selected Tower: ", definition.t_name)

func f_auto_wave(enabled: bool) -> void:
	auto_wave = enabled

	if auto_wave and not GameManager.g_over:
		wave_timer.start()
	else:
		wave_timer.stop()
	
func _on_wave_timer_timeout() -> void:
	wave_timer.stop()

	if not auto_wave:
		return

	await create_wave()

	if auto_wave and not GameManager.g_over and GameManager.wave < GameManager.top_wave:
		wave_timer.start()
	
func create_wave():
	print(GameManager.wave)
	if GameManager.g_over or wave_in_progress or not GameManager.new_wave():
		return
		
	wave_in_progress = true
	gui.set_wave(GameManager.wave)
	
	var b_array = w_catalog.get_balloons_for_wave(GameManager.wave,b_catalog.b_definitions)
	
	await m_generator.spawn_ballons(b_array)

	while b_node.get_child_count() > 0:
		await get_tree().create_timer(3.0).timeout
		
	wave_in_progress = false

	if GameManager.wave < GameManager.top_wave:
		wave_timer.start()
		
func u_lives()->void:
	gui.set_lives(GameManager.lives)

func u_money()->void:
	gui.set_money(GameManager.money)	
	
func _on_game_over() -> void:
	wave_in_progress = false
	wave_timer.stop()
	get_tree().paused = true
			
func _process(delta: float) -> void:
	gui.set_time(GameManager.elapsed_time)

extends Node
class_name MapGenerator
@onready var background: TileMapLayer = $scenary/background
@onready var path_layer: TileMapLayer = $scenary/path
@export var b_scene : PackedScene
@onready var b_node: Node2D = $ballons

#Mejora hacerlo con una funcion
@export var t_start : Vector2i
@export var t_end : Vector2i

#TODO
func get_path_start_end() -> void:
	pass

func make_path() -> Array[Vector2i]:
	var rect : Rect2 = path_layer.get_used_rect()
	var astar =  AStarGrid2D.new()
	
	astar.region = rect
	astar.cell_size = Vector2i(1,1)
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	
	var used_cells = path_layer.get_used_cells()

	# 2. Bloqueamos cualquier celda de la región que NO esté dibujada
	for x in range(rect.position.x, rect.end.x):
		for y in range(rect.position.y, rect.end.y):
			var coords = Vector2i(x, y)
			if not used_cells.has(coords):
				astar.set_point_solid(coords, true)
	
	return astar.get_id_path(t_start,t_end)

func spawn_ballons(total: int,path : Array)-> void:
	await get_tree().create_timer(2.0).timeout
	for i in total:
		var b = b_scene.instantiate() as Ballon
		b.name = "ballon"+ str(i)
		
		var cell_path: Array[Vector2i] = make_path()
		var world_path: PackedVector2Array = []

		for cell in cell_path:
			world_path.append(path_layer.map_to_local(cell))
				
		b_node.add_child(b)
		
		b.setup(randi_range(1,7),150,world_path)
		
		await get_tree().create_timer(0.5).timeout

func _ready() -> void:
	var path = make_path()
	spawn_ballons(100,path)

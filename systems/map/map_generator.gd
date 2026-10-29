extends Node
class_name MapGenerator

var path_layer : Node2D
var b_scene : PackedScene
var b_node : Node2D
var path 

#Mejora hacerlo con una funcion
var t_start : Vector2i 
var t_end : Vector2i 


#TODO
func _setup(_path_layer: Node2D , _b_scene : PackedScene ,_b_node :Node2D,cell_start : Vector2i,cell_end: Vector2i) -> void:
	path_layer = _path_layer
	b_scene = _b_scene
	b_node = _b_node
	t_start = cell_start
	t_end = cell_end 
	path = make_path()

func get_path_start_end() -> void:
	pass

func make_path() -> Array[Vector2i]:
	var rect : Rect2 = path_layer.get_used_rect()
	var astar =  AStarGrid2D.new()
	
	rect = rect.expand(t_start)
	rect = rect.expand(t_end)
	
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

func spawn_ballons(_ballons:Array)-> void:
	for i : BallonDefinitions in _ballons:
		var b = b_scene.instantiate() as Ballon
		b.name = "ballon"+ str(i)
		
		var cell_path: Array[Vector2i] = path
		var world_path: PackedVector2Array = []

		for cell in cell_path:
			world_path.append(path_layer.map_to_local(cell))
				
		b_node.add_child(b)
		
		b.setup(i.hp, i.speed, world_path, i.reward)
		await b_node.get_tree().create_timer(0.5).timeout
		

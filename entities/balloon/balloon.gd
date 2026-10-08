extends Node2D
class_name Ballon

var hp : int = 1
var speed : float = 200.0 

var path: PackedVector2Array = []
var target_point_index: int = 0

func set_path(_path: PackedVector2Array) -> void:
	path = _path
	target_point_index = 0
	
	if path.size() > 0:
		global_position = path[0]
		target_point_index = 1

func _process(delta: float) -> void:
	var target_position = path[target_point_index]
	global_position = global_position.move_toward(target_position, speed * delta)

	if global_position.distance_to(target_position) < 2.0:
		target_point_index += 1
		if target_point_index >= path.size():
			_on_path_finished()

func _on_path_finished() -> void:
	queue_free() # Destruye el globo al llegar al final

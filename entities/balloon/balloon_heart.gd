extends Ballon
class_name BallonHeart

var bh_sprites : Dictionary = {
	1:load("res://assets/texture/ballons/normal/b_red.tres"),
	2:load("res://assets/texture/ballons/normal/b_blue.tres"),
	3:load("res://assets/texture/ballons/normal/b_yellow.tres"),
	4:load("res://assets/texture/ballons/normal/b_green.tres"),
	5:load("res://assets/texture/ballons/normal/b_orange.tres"),
	6:load("res://assets/texture/ballons/normal/b_purple.tres"),
	7:load("res://assets/texture/ballons/normal/b_rainbow.tres")
}

func _process(delta: float) -> void:
	if is_instance_valid(self):
		if target_point_index < path.size():
			var target_position = path[target_point_index]
			global_position = global_position.move_toward(target_position, speed * delta)

			if global_position.distance_to(target_position) < 2.0:
				target_point_index += 1
				if target_point_index >= path.size():
					_on_path_finished()
	

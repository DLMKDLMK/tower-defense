extends Node2D
class_name Ballon

var b_name : String
var hp : int = 1
var speed : float = 200.0 
#TODO el path tienen que recuperarlo del GameManager
var path: PackedVector2Array = []
var target_point_index: int = 0
@onready var sprite_2d: Sprite2D = $Sprite2D

var type_balloons : Dictionary = {
	1:load("res://assets/texture/ballons/r_ballons.tres"),
	2:load("res://assets/texture/ballons/b_ballons.tres"),
	3:load("res://assets/texture/ballons/g_ballons.tres"),
	4:load("res://assets/texture/ballons/y_ballons.tres")
}

func get_velocity() -> Vector2:
	if path.size() == 0 or target_point_index >= path.size():
		return Vector2.ZERO
	var target_position = path[target_point_index]
	var dir = (target_position - global_position).normalized()
	return dir * speed

func setup(_hp:int,_speed:int,_path:PackedVector2Array)-> void:
	set_color(_hp)
	speed = _speed
	set_path(_path)
	
func set_color(_hp) -> void:
	hp = _hp
	sprite_2d.texture = type_balloons.get(hp)

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
	destroy_balloon()
	
func destroy_balloon() -> void :
	queue_free()
	
func set_damage(_damage) -> void:
	hp = hp - _damage
	if hp <= 0:
		destroy_balloon()
	else:
		set_color(hp)

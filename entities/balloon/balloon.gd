extends Node2D
class_name Ballon

var b_name : String
var hp : int = 1
var speed : float = 200.0 
#TODO el path tienen que recuperarlo del GameManager
var path: PackedVector2Array = []
var target_point_index: int = 0
var b_type : Constants.ballon_type = Constants.ballon_type.NORMAL
var reward : int = 5
var is_removed := false
@onready var sprite_2d: Sprite2D = $Sprite2D

var b_exp : Texture2D = load("res://assets/texture/ballons/b_explosion.tres") 

var b_sprites : Dictionary = {
	1:load("res://assets/texture/ballons/normal/b_red.tres"),
	2:load("res://assets/texture/ballons/normal/b_blue.tres"),
	3:load("res://assets/texture/ballons/normal/b_green.tres"),
	4:load("res://assets/texture/ballons/normal/b_yellow.tres"),
	5:load("res://assets/texture/ballons/normal/b_orange.tres"),
	6:load("res://assets/texture/ballons/normal/b_purple.tres"),
	7:load("res://assets/texture/ballons/normal/b_rainbow.tres")
}

func get_velocity() -> Vector2:
	if path.size() == 0 or target_point_index >= path.size():
		return Vector2.ZERO
	var target_position = path[target_point_index]
	var dir = (target_position - global_position).normalized()
	return dir * speed

func setup(_hp:int, _speed:float, _path:PackedVector2Array, _reward:int) -> void:
	set_color(_hp)
	speed = _speed
	set_path(_path)
	reward = _reward
	
func set_color(_hp) -> void:
	hp = _hp
	sprite_2d.texture = b_sprites.get(hp)

func set_path(_path: PackedVector2Array) -> void:
	path = _path
	target_point_index = 0
	
	if path.size() > 0:
		global_position = path[0]
		target_point_index = 1

func _process(delta: float) -> void:
	if is_instance_valid(self):
		if target_point_index < path.size():
			var target_position = path[target_point_index]
			global_position = global_position.move_toward(target_position, speed * delta)

			if global_position.distance_to(target_position) < 2.0:
				target_point_index += 1
				if target_point_index >= path.size():
					_on_path_finished()

func _on_path_finished() -> void:
	if is_removed:
		return
	is_removed = true
	GameManager.subtract_lives(hp)
	destroy_balloon()
	
func destroy_balloon() -> void :
	sprite_2d.texture = b_exp
	await get_tree().create_timer(0.1).timeout
	queue_free()
	
func set_damage(_damage) -> void:
	if is_removed:
		return

	hp = hp - _damage
	if hp <= 0:
		is_removed = true
		GameManager.add_money(reward)
		destroy_balloon()
	else:
		set_color(hp)

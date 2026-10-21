extends Ballon
class_name BallonArmored
@export var armor_hp : int = 1
enum brick_states {state0,state1,state2,state3,state4}
var b_state : brick_states = brick_states.state0
var brick_state_texture = {
	brick_states.state1 : load("res://assets/texture/ballons/normal/b_brick/b_brick_1.tres"),
	brick_states.state2 : load("res://assets/texture/ballons/normal/b_brick/b_brick_2.tres"),
	brick_states.state3 : load("res://assets/texture/ballons/normal/b_brick/b_brick_3.tres"),
	brick_states.state4:  load("res://assets/texture/ballons/normal/b_brick/b_brick_4.tres")
}

func setup(_hp:int,_speed:int,_path:PackedVector2Array)-> void:
	hp = _hp
	speed = _speed
	set_path(_path)
	if armor_hp == 1:
		sprite_2d.texture = load("res://assets/texture/ballons/normal/b_iron.tres")
	else: 
		sprite_2d.texture = brick_state_texture.state1
		b_state = brick_states.state1

func change_state(_state: brick_states) -> void:
	match _state:
		brick_states.state1:
			b_state = brick_states.state2
		brick_states.state2:
			b_state = brick_states.state3
		brick_states.state3:
			b_state = brick_states.state4
		brick_states.state4:
			b_state = brick_states.state0
		
	sprite_2d.texture = brick_state_texture.b_state

func set_damage(_damage) -> void:
	if b_state != brick_states.state0:
		change_state(b_state)
	else:
			 
		hp = hp - _damage
		if hp <= 0:
			destroy_balloon()
		else:
			set_color(hp)

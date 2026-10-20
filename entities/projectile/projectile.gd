extends Node2D
class_name ProjectileGeneric

@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var p_name : String = "P_DART"
@export var speed : float = 600.0 
var damage : int 
var objective : Node2D
@export var d_type : Constants.damage_type = Constants.damage_type.IMPACT
 
func setup(_damage :int , _obj : Node2D) -> void: 
	damage = _damage
	objective = _obj
	
func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)
	area_2d.area_exited.connect(_on_area_exit)

func _on_area_entered(area: Area2D)-> void:
	var colision = area.get_parent()
	if colision == objective :
		objective.set_damage(damage)
		_on_impact()
	
func _on_area_exit(area: Area2D)-> void:
	if area.get_parent() == get_parent():
		queue_free()
		

func _process(delta: float) -> void:
	if is_instance_valid(objective):
		look_at(objective.position)
		rotation += deg_to_rad(135) 
		global_position = global_position.move_toward(objective.position, speed * delta)
		
	else:
		queue_free()
	
func _on_impact() -> void:
	queue_free()
	
func predict_position(t_posicion: Vector2, target: Ballon) -> Vector2:
	if speed <= 0.0:
		return target.global_position
	var to_target = target.global_position - t_posicion
	var t = to_target.length() / speed
	return target.global_position + target.get_velocity() * t

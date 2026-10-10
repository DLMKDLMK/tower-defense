extends Node2D
class_name ProjectileGeneric

@onready var area_2d: Area2D = $Area2D
@export var p_name : String = "P_DART"
@export var speed : float = 600.0 
var damage : int 
var objective : Node2D

func setup(_damage :int , _obj : Node2D) -> void: 
	damage = _damage
	objective = _obj

func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)
	area_2d.area_exited.connect(_on_area_exit)

func _on_area_entered(area: Area2D)-> void:
	var colision = area.get_parent()
	if colision == objective  :
		objective.set_damage(damage)
		_on_impact()
	
func _on_area_exit(area: Area2D)-> void:
	if area.get_parent() is TurretGeneric:
		queue_free()
		

func _process(delta: float) -> void:
	if is_instance_valid(objective):
		global_position = global_position.move_toward(objective.position, speed * delta)
	else:
		queue_free()
	
func _on_impact() -> void:
	queue_free()

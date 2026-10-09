extends Node2D
class_name TurretGeneric
@export var t_name : String = "t_name_generic"
@export var t_range : int = 50
@export var damage : int = 1
@export var att_speed : int = 2
@export var price : int = 100
@export var projectile : PackedScene
@export var placeable : String = "Ground"
@onready var range_area: Area2D = $RangeArea
var objective : Node2D
var objectives : Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	range_area.area_entered.connect(_on_area_entered)
	range_area.area_exited.connect(_on_area_exit)

func _on_area_entered(area: Area2D)-> void:
	if area.get_parent() is Ballon:
		var b = area.get_parent()
		objectives.append(b)
		objective = objectives.front()
		print(b)
	
func _on_area_exit(area: Area2D)-> void:
	if objective.name == area.get_parent().name :
		if !objectives.is_empty(): 
			objective = objectives.pop_front()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if objective != null:
		look_at(objective.position)

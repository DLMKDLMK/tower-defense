extends Resource
class_name TurretDefinition

@export var t_name : String = "t_name_generic"
@export var t_range : int = 50
@export var damage : int = 1
@export var att_speed : int = 2
@export var price : int = 100
@export var placeable : String = "Ground"
@export var projectile : PackedScene
@export var sprite : Texture2D 
@export_enum("BASIC","MACHINE") var type = "BASIC"

func _to_string() -> String:
	return str(type," : ",t_name," : ",t_range," : ",price," : ",placeable , " : ",projectile)

extends ProjectileGeneric
class_name ProjectilePineapple
signal signal_delete
var s :int = 3
@onready var label: Label = $Area2D/Label
@onready var exp_area: Area2D = $ExpArea2D
var p_exp : Texture2D = load("res://assets/texture/projectile/p_bomb_exp.tres")

func setup(_damage :int , _obj : Node2D) -> void: 
	damage = _damage
	objective = _obj
	
func _on_area_exit(area: Area2D)-> void:
	pass
		
func _process(delta: float) -> void:
	pass

func explodes() -> void:
	for area in exp_area.get_overlapping_areas():
		if area.get_parent() is Ballon:
			var b = area.get_parent()
			b.set_damage(damage)
				
	sprite_2d.texture = p_exp
	
	signal_delete.emit()

func _on_exp_area_entered(area: Area2D) -> void:
	if area.get_parent() is Ballon:
		var b = area.get_parent()
		b.set_damage(damage)

func _on_timer_timeout() -> void:
	s = s - 1
	label.text = str(s)
	if s == 0:
		label.text = ""
		explodes()
		

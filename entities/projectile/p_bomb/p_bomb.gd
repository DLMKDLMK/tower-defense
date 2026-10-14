extends ProjectileGeneric
class_name ProjectileBomb
@onready var exp_area: Area2D = $ExpArea2D
var p_exp : Texture2D = load("res://assets/texture/projectile/p_bomb_exp.tres")


func setup(_damage :int , _obj : Node2D) -> void:
	damage = _damage
	objective = _obj
	exp_area.monitoring = false	

func _on_area_entered(area: Area2D)-> void:
	var colision = area.get_parent()
	if colision == objective  :
		exp_area.monitoring = true
		sprite_2d.texture = p_exp
		await get_tree().create_timer(0.2).timeout
		exp_area.monitoring = false
		queue_free()
		
func _on_area_exit(area: Area2D)-> void:
	if area.get_parent() is TurretGeneric:
		await get_tree().create_timer(0.1).timeout
		queue_free()

func _on_exp_area_entered(area: Area2D) -> void:
	if area.get_parent() is Ballon:
		var b = area.get_parent()
		b.set_damage(damage)

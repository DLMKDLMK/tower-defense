extends ProjectileGeneric
class_name ProjectileStar
var rotation_speed: float = 50.0

func _on_area_entered(area: Area2D)-> void:
	if area.get_parent() is Ballon :
		var b = area.get_parent()
		b.set_damage(damage)
		if area.get_parent() == objective  :
			_on_impact()

func _process(delta: float) -> void:
	rotation += rotation_speed * delta
	if is_instance_valid(objective):
		global_position = global_position.move_toward(predict_position(get_parent().global_position,objective), speed * delta)
		
	else:
		queue_free()

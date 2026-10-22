extends ProjectileGeneric
class_name ProjectileNail

func _on_area_entered(area: Area2D)-> void:
	if area.get_parent() is Ballon :
		var b = area.get_parent()
		b.set_damage(damage)
		_on_impact()
			
func _on_area_exit(area: Area2D)-> void:
	queue_free()
		

func _process(delta: float) -> void:
	var direction = global_transform.x.normalized()
	global_position += direction * speed * delta
	look_at(global_position )

extends ProjectileGeneric
class_name ProjectileAxe

var rotation_speed: float = 25.0

var center: Vector2
var radius: float
var angle: float
var start_angle: float
var angular_speed: float
var is_returning: bool = false

func setup(_damage :int , _obj : Node2D) -> void:	
	damage = _damage
	objective = _obj

	var tower_pos = get_parent().position
	var direction = (predict_position(tower_pos,_obj) - tower_pos).normalized()
	var perp = direction.rotated(PI / 2)
	radius = 70
	center = tower_pos + perp * radius
	start_angle = (tower_pos - center).angle()
	angle = start_angle
	angular_speed = speed / radius
	global_position = tower_pos

func _on_area_entered(area: Area2D)-> void:
	if area.get_parent() is Ballon :
		var b = area.get_parent()
		b.set_damage(damage)
		
func _on_area_exit(area: Area2D)-> void:
	pass

func _process(delta: float) -> void:
	rotation += rotation_speed * delta
	
	if is_returning:
		return

	angle += angular_speed * delta
	global_position = center + Vector2(cos(angle), sin(angle)) * radius
	if angle >= start_angle + TAU:
		is_returning = true
		queue_free()
		

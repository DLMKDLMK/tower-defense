extends TurretGeneric
class_name TurretMachine
var p_number : int = 6

func create_proyectile() -> void:
	var rotation : float = 0
	for i in range(p_number):
		var p = projectile.instantiate() as ProjectileNail
		p.position = marker_2d.position
		p.rotation = deg_to_rad(360.0*i/p_number)
		marker_2d.add_child(p)
		rotation += 45
		
		p.setup(damage,objective)

func _on_shoot_timer_timeout() -> void:
	if !objectives.is_empty():
		create_proyectile() 
		
func _process(delta: float) -> void:
	pass
		

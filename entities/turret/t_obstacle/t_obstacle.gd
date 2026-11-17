extends TurretGeneric
class_name TurretObstacle

func create_proyectile() -> void:
	var p = projectile.instantiate() 
	p.position = marker_2d.position
	marker_2d.add_child(p)
	p.setup(damage,objective)
	p.signal_delete.connect(delete)
	sprite_2d.texture = null

func _process(delta: float) -> void:
	pass

func delete()->void:
	await get_tree().create_timer(0.2).timeout
	queue_free()

func set_active():
	active = true
	create_proyectile()

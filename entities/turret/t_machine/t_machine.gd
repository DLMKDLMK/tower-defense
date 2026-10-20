extends TurretGeneric
class_name TurretMachine
@onready var spawn_marker = [$Sprite2D/Spawn1, $Sprite2D/Spawn2, $Sprite2D/Spawn3, $Sprite2D/Spawn4, $Sprite2D/Spawn5, $Sprite2D/Spawn6, $Sprite2D/Spawn7, $Sprite2D/Spawn8]

func create_proyectile() -> void:
	for s in spawn_marker:
		var p = projectile.instantiate() as ProjectileGeneric
		p.position = marker_2d.position
		s.add_child(p)
		p.setup(damage,objective)

func _on_shoot_timer_timeout() -> void:
	if !objectives.is_empty():
		create_proyectile() 
		
func _process(delta: float) -> void:
	pass
		

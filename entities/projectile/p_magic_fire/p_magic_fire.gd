extends ProjectileGeneric
class_name ProjectileMagicFire
var p_static : bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

func be_placed() -> void:
	if p_static == false:
		animation_player.play("fire")
		timer.start()
		p_static = true
		scale = scale*2
		rotate(0.0)
		if is_instance_valid(objective):
			global_position = objective.global_position
	

func _on_area_entered(area: Area2D)-> void:
	var colision = area.get_parent()
	if colision is Ballon:
		var b = area.get_parent()
		b.set_damage(damage)
		
	if colision == objective :
		be_placed()
		
func _on_area_exit(area: Area2D)-> void:
	if area.get_parent() is TurretGeneric:
		be_placed()
		

func _process(delta: float) -> void:
	if is_instance_valid(objective):
		if p_static == false:
			global_position = global_position.move_toward(objective.position, speed * delta)
	else:
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()

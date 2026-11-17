extends ProjectileGeneric
class_name ProjectileStackNails
var hp = 10
signal signal_delete

var p_sprites : Dictionary = {
	1:load("res://assets/texture/obstacle/o_nails_0.tres"),
	2:load("res://assets/texture/obstacle/o_nails_1.tres"),
	3:load("res://assets/texture/obstacle/o_nails_2.tres"),
	4:load("res://assets/texture/obstacle/o_nails_3.tres"),
}

func setup(_damage :int , _obj : Node2D) -> void: 
	damage = _damage
	objective = _obj
	sprite_2d.texture = p_sprites.get(4)

func set_sprite()->void:
	if hp == 6 :
		sprite_2d.texture = p_sprites.get(3)
	if hp == 4:
		sprite_2d.texture = p_sprites.get(2)
	if hp == 2:
		sprite_2d.texture = p_sprites.get(1)

func _on_impact() -> void:
	hp-= 1
	if hp < 0:
		queue_free()
		signal_delete.emit()
	set_sprite()
	
func _on_area_entered(area: Area2D)-> void:
	var colision = area.get_parent()
	if colision is Ballon :
		colision.set_damage(damage)
		_on_impact()
	
func _on_area_exit(area: Area2D)-> void:
	pass
		
func _process(delta: float) -> void:
	pass

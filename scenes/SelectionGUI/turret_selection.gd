extends Control

var preview_turret : TurretGeneric
var main : Node2D 


func _ready() -> void:
	main = get_parent().get_parent()

func set_preview(turret: TurretGeneric) -> void:
	preview_turret = turret

func _process(delta: float) -> void:
	if preview_turret == null:
		return
		
	global_position = get_global_mouse_position()
	
	if can_place_turret():
		preview_turret.sprite_2d.modulate = Color.WHITE
	else:
		preview_turret.sprite_2d.modulate = Color.RED
		
#comprobar el overlap_area de t_preview si tiene contacto con otra torre y tambien comprobar el terreno
func can_place_turret() -> bool:
	if preview_turret == null:
		return false

	var overlap_area := preview_turret.get_node_or_null("OverlapArea") as Area2D
	if overlap_area == null:
		return false

	for area in overlap_area.get_overlapping_areas():
		var other_turret := area.get_parent()
		if other_turret is TurretGeneric and other_turret != preview_turret:
			return false

	var cell = main.background.local_to_map(
		main.background.to_local(preview_turret.global_position)
	)
	
	var tile_data = main.background.get_cell_tile_data(cell)

	if tile_data == null:
		return false

	var tile_type := str(tile_data.get_custom_data("type")).to_lower()

	return tile_type == preview_turret.placeable.to_lower()

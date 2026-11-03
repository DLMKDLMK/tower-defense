extends Control

@onready var btn_confirm: Button = $TextureRect/HBoxContainer/BtnConfirm
@onready var btn_cancel: Button = $TextureRect/HBoxContainer/BtnCancel

signal t_confirm
signal t_cancel
var t_definition: TurretDefinition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		global_position = get_global_mouse_position()


func _on_btn_confirm_button_down() -> void:
	t_confirm.emit()


func _on_btn_cancel_button_down() -> void:
	t_cancel.emit()


func _on_overlap_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is TurretGeneric:
		print(area.get_parent().t_name)

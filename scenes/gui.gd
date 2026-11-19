extends Control
class_name GuiLabel
@onready var gui: GuiLabel = $"."
@onready var value_time: Label = $HBoxContainer/TimeContainer/ValueTime
@onready var value_wave: Label = $HBoxContainer/WaveContainer/ValueWave
@onready var value_lives: Label = $HBoxContainer/LiveContainer/ValueLives
@onready var value_money: Label = $HBoxContainer/MoneyContainer/ValueMoney
@onready var button: Button = $TurretContainer/Panel/VContainer/NextButton
@onready var auto_btn : CheckButton = $TurretContainer/Panel/VContainer/CheckButton
@onready var turret_container: VBoxContainer = $TurretContainer
@onready var gtc: GridContainer = $TurretContainer/Panel/MarginContainer/GridTextureContainer

@onready var turret_info: Panel = $TurretInfo
@onready var info_label: Label = $TurretInfo/MarginContainer/VBoxContainer/HBoxContainer/InfoLabel
@onready var delete_btn: Button = $TurretInfo/MarginContainer/VBoxContainer/DeleteBtn
@onready var game_over_overlay: Control = $GameOverOverlay
@onready var game_over_wave: Label = $GameOverOverlay/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/WaveLabel

signal turret_selected(definition: TurretDefinition)
signal auto_wave_on(boolean: bool)
func setup(_wave,_live,money,_turrets) -> void:
	value_wave.text = str(_wave)
	value_lives.text = str(_live)
	render_turrets(_turrets)
	value_money.text = str(money)
	value_time.text = str(0)
	mouse_filter = 2
	turret_info.visible = false
	game_over_overlay.visible = false

func set_lives(_number) -> void:
	value_lives.text = str(maxi(_number, 0))

func show_game_over(final_wave: int, max_wave: int) -> void:
	game_over_wave.text = "Wave reached: %d / %d" % [final_wave, max_wave]
	game_over_overlay.visible = true
	button.disabled = true
	auto_btn.disabled = true
	auto_btn.set_pressed_no_signal(false)

func set_money(_number) -> void:
	value_money.text = ""
	value_money.text = str(_number)
	update_money_turrets()
	
func set_wave(_number) -> void:
	value_wave.text = str(_number)
	
func set_time(time: float) -> void:
	var minutes := floori(time / 60.0)
	var seconds := int(time) % 60
	value_time.text = "%02d:%02d" % [minutes, seconds]
	
func _on_button_button_down() -> void:
	await gui.get_parent().get_parent().create_wave()
	button.disabled = auto_btn.button_pressed

func _on_turret_button_pressed(definition: TurretDefinition) -> void:
	turret_selected.emit(definition)
	
func render_turrets(turrets: Array) -> void:
	var n:int = 1
	for t: TurretDefinition in turrets:
		var card := VBoxContainer.new()
		card.alignment = BoxContainer.ALIGNMENT_CENTER
		card.name = "card"+str(n)
		var icon := TextureButton.new()
		icon.name = "icon"
		icon.pressed.connect(_on_turret_button_pressed.bind(t))
		icon.texture_normal = t.sprite
		icon.ignore_texture_size = true
		icon.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		icon.custom_minimum_size = Vector2(48, 48)

		var price := Label.new()
		price.name= "label"
		price.text = "$%d" % t.price
		price.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		
		card.set_meta("turret_definition", t)
		card.add_child(icon)
		card.add_child(price)
		gtc.add_child(card)
		n += 1
		
	update_money_turrets() 
	
func update_money_turrets() -> void:
	if gtc.get_children().is_empty()==true:
		return
		
	for card in gtc.get_children():
		var d :=card.get_meta("turret_definition")as TurretDefinition
		
		if d.price <= GameManager.money:
			card.get_node("icon").modulate = Color.WHITE
			card.get_node("label").modulate = Color.WHITE
			card.get_node("icon").disabled = false
		else:
			card.get_node("icon").modulate = Color.DIM_GRAY
			card.get_node("label").modulate = Color.RED 
			card.get_node("icon").disabled = true

func _on_check_button_toggled(toggled_on: bool) -> void:
	auto_wave_on.emit(toggled_on)
	var main = gui.get_parent().get_parent()
	button.disabled = toggled_on or main.wave_in_progress

func set_turret_info(_t : TurretGeneric)->void:
	info_label.text= _t.t_name
	delete_btn.set_meta("turret_data",_t)

func _on_delete_btn_button_down() -> void:
	var t : TurretGeneric = delete_btn.get_meta("turret_data")
	GameManager.add_money(t.price/2)
	t.queue_free()

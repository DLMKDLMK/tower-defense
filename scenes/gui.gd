extends Control
class_name GuiLabel
@onready var gui: GuiLabel = $"."
@onready var value_time: Label = $HBoxContainer/TimeContainer/ValueTime
@onready var value_wave: Label = $HBoxContainer/WaveContainer/ValueWave
@onready var value_lives: Label = $HBoxContainer/LiveContainer/ValueLives
@onready var value_money: Label = $HBoxContainer/MoneyContainer/ValueMoney
@onready var button: Button = $TurretContainer/Panel/Button
@onready var turret_container: VBoxContainer = $TurretContainer
@onready var gtc: GridContainer = $TurretContainer/Panel/MarginContainer/GridTextureContainer
signal turret_selected(definition: TurretDefinition)

func setup(_wave,_live,money,_turrets) -> void:
	value_wave.text = str(_wave)
	value_lives.text = str(_live)
	value_money.text = str(money)
	value_time.text = str(0)
	render_turrets(_turrets)

func set_lives(_number) -> void:
	if _number > 0 :
		value_lives.text = str(maxi(_number, 0))

func set_money(_number) -> void:
	value_money.text = ""
	value_money.text = str(_number)
	
func set_wave(_number) -> void:
	value_wave.text = str(_number)
	
func set_time(time: float) -> void:
	var minutes := floori(time / 60.0)
	var seconds := int(time) % 60
	value_time.text = "%02d:%02d" % [minutes, seconds]
	
func _on_button_button_down() -> void:
	button.disabled = true
	await gui.get_parent().get_parent().create_wave()
	button.disabled = false

func _on_turret_button_pressed(definition: TurretDefinition) -> void:
	turret_selected.emit(definition)

func render_turrets(turrets: Array) -> void:
	for t: TurretDefinition in turrets:
		var card := VBoxContainer.new()
		card.alignment = BoxContainer.ALIGNMENT_CENTER

		var icon := TextureButton.new()
		icon.pressed.connect(_on_turret_button_pressed.bind(t))
		icon.texture_normal = t.sprite
		icon.ignore_texture_size = true
		icon.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		icon.custom_minimum_size = Vector2(48, 48)

		var price := Label.new()
		price.text = "$%d" % t.price
		price.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

		card.add_child(icon)
		card.add_child(price)
		gtc.add_child(card)

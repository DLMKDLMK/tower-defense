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

func render_turrets(_turrets:Array)->void:
	
	for t : TurretDefinition in _turrets:
		var t_rect = TextureRect.new()
		t_rect.name = t.t_name
		t_rect.texture = t.sprite
		t_rect.custom_minimum_size = Vector2(48,48)
		t_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		t_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		gtc.add_child(t_rect)
		
	
	pass

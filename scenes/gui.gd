extends Control
class_name GuiLabel
@onready var value_time: Label = $HBoxContainer/TimeContainer/ValueTime
@onready var value_wave: Label = $HBoxContainer/WaveContainer/ValueWave
@onready var value_lives: Label = $HBoxContainer/LiveContainer/ValueLives
@onready var value_money: Label = $HBoxContainer/MoneyContainer/ValueMoney

func setup(_wave,_live,money) -> void:
	value_wave.text = str(_wave)
	value_lives.text = str(_live)
	value_money.text = str(money)
	value_time.text = str(0)

func set_lives(_number) -> void:
	value_lives.text = str(_number)

func set_money(_number) -> void:
	value_lives.text = str(_number)
	
func set_wave(_number) -> void:
	value_wave.text = str(_number)
	
func set_time(time: float) -> void:
	var minutes := floori(time / 60.0)
	var seconds := int(time) % 60
	value_time.text = "%02d:%02d" % [minutes, seconds]
	

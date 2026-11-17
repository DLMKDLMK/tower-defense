extends Node2D
class_name TurretGeneric

@onready var range_area: Area2D = $RangeArea
@onready var range_colision: CollisionShape2D = $RangeArea/RangeColision
@onready var shoot_timer: Timer = $ShootTimer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var marker_2d: Marker2D = $Sprite2D/Marker2D
@onready var range_line: Line2D = $RangeLine

@export var t_name : String = "t_name_generic"
@export var t_range : int = 50
@export var damage : int = 1
@export var att_speed : float = 0.5
@export var price : int = 100
@export var projectile : PackedScene
@export var placeable : String = "Ground"

var active = false
var objective : Node2D
var objectives : Array[Node2D]
signal selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if range_area:
		range_area.area_entered.connect(_on_area_entered)
		range_area.area_exited.connect(_on_area_exit)
		shoot_timer.timeout.connect(_on_shoot_timer_timeout)
		shoot_timer.stop()
		range_line.visible = true
	
func setup(_td : TurretDefinition) -> void:
	t_name = _td.t_name
	t_range = _td.t_range
	damage  = _td.damage
	att_speed  = _td.att_speed
	price  = _td.price
	projectile = _td.projectile
	placeable = _td.placeable
	sprite_2d.texture = _td.sprite
	
	if range_colision and range_colision.shape is CircleShape2D:
		range_colision.shape.set_radius(t_range)
		
		if range_line.visible == true:
			range_line.radius = t_range
			range_line.update_circle_line()
	
	shoot_timer.wait_time = 1.0 / att_speed

func set_select(b :bool)->void:
	if range_line:
		if b:
			range_line.visible = true
		else:
			range_line.visible = false

func set_active():
	active = true
	
	for area in range_area.get_overlapping_areas():
		_on_area_entered(area)
		
	shoot_timer.start()

func _on_area_entered(area: Area2D)-> void:
	if active == false:
		return 
		
	if area.get_parent() is Ballon:
		var b = area.get_parent()
		objectives.append(b)
		objective = objectives.front()
	
func _on_area_exit(area: Area2D)-> void:
	if active == false:
		return 
		
	if is_instance_valid(area):
		objectives.erase(area.get_parent())
		if objective == area.get_parent() :
			if objectives.is_empty(): 
				objective = null
			else :
				objective = objectives.front()

func create_proyectile() -> void:
	var p = projectile.instantiate() as ProjectileGeneric
	p.position = marker_2d.position
	add_child(p)
	p.setup(damage,objective)
	
func _on_shoot_timer_timeout() -> void:
	if objective != null:
		create_proyectile() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active == false:
		return 
		
	if objective != null:
		sprite_2d.look_at(objective.position)
		sprite_2d.rotation += deg_to_rad(135) 
		
func _on_overlap_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and active == true:
		selected.emit(self)

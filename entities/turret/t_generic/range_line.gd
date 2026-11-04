extends Line2D
@onready var range_colision: CollisionShape2D = $"../RangeArea/RangeColision"
var segments: int = 64
var radius : float 

func _ready() -> void:
	radius = get_parent().t_range
	update_circle_line()

func _process(_delta: float) -> void:
	pass

func update_circle_line() -> void:
		
	var center: Vector2 = range_colision.position
	
	clear_points()
	
	for i in range(segments + 1):
		var angle: float = (i as float / segments) * TAU
		var point_position: Vector2 = center + Vector2(cos(angle), sin(angle)) * radius
		add_point(point_position)

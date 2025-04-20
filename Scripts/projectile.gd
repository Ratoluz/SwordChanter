extends Area2D

var angle
var speed: float
var damage: float
var is_critical: bool
var spread = 0

func initialize():
	var angle_offset: float = 0
	angle_offset = randf_range(-spread, spread)
	angle_offset = deg_to_rad(angle_offset)
	angle += angle_offset
	rotation = angle + deg_to_rad(45)
	
func _ready() -> void:
	area_shape_entered.connect(_on_area_shape_entered)
	
func _move(delta):
	var dir = Vector2(cos(angle), sin(angle))
	position += dir * speed * delta

func _process(delta: float) -> void:
	_move(delta)

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.name == 'Dummy':
		area.take_damage(damage, is_critical)
		queue_free()

class_name Projectile
extends Area2D

var angle
var speed: float
var damage: float
var is_critical: bool
var spread = 0
var timer: SceneTreeTimer
var rotate_sprite
var live_time 

func _process(delta: float) -> void:
	_move(delta)

func _init() -> void:
	body_shape_entered.connect(_on_body_shape_entered)
	body_entered.connect(_on_body_entered)
	
func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body is DamageTaker:
		body.take_damage(damage, is_critical)
		queue_free()
		
func _on_body_entered(body: Node):
	if body is TileMapLayer:
		queue_free()  

func initialize():
	var angle_offset: float = 0
	angle_offset = randf_range(-spread, spread)
	angle_offset = deg_to_rad(angle_offset)
	angle += angle_offset
	if rotate_sprite:	
		global_rotation = angle + deg_to_rad(45)
	else:
		global_rotation = angle + deg_to_rad(90)
	timer = get_tree().create_timer(live_time)
	timer.timeout.connect(die)

func die():
	queue_free()
	
func _move(delta):
	var dir = Vector2(cos(angle), sin(angle))
	position += dir * speed * delta

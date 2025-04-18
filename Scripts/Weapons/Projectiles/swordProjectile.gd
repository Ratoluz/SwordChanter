extends Area2D

var angle
var speed: float
var damage: float
var is_critical: bool

func _move(delta):
	rotation = angle + deg_to_rad(45)
	var dir = Vector2(cos(angle), sin(angle))
	position += dir * speed * delta

func _process(delta: float) -> void:
	_move(delta)


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.name == 'Dummy':
		area.play_anim()
		area.display_damage(damage, is_critical)
		queue_free()

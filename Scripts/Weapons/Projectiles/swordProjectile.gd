extends Area2D

var angle
var speed

func _move(delta):
	rotation = angle + deg_to_rad(45)
	var dir = Vector2(cos(angle), sin(angle))
	position += dir * speed * delta

func _process(delta: float) -> void:
	_move(delta)

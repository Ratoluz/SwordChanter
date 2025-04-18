extends Area2D

var popUp: PackedScene = preload("res://Objects/Other/damagePopUp.tscn")

func play_anim():
	$AnimatedSprite2D.play('hit')

func _on_animated_sprite_2d_animation_looped() -> void:
	$AnimatedSprite2D.stop()

func display_damage(damage):
	var tempPopUp = popUp.instantiate()
	tempPopUp.position = position + Vector2(0,-70)
	get_tree().root.add_child(tempPopUp)

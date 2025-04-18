extends Area2D

var pop_up: PackedScene = preload("res://Objects/Other/damagePopUp.tscn")

@onready var dps_label = $Dps
var damage_history = []
var dps = 0
var dps_damage_time = 2.0

func _on_animated_sprite_2d_animation_looped() -> void:
	$AnimatedSprite2D.stop()

func _add_to_damage_history(damage):
	var now = Time.get_ticks_msec() 
	damage_history.append({"time": now, "damage": damage})

func _calculate_dps():
	if len(damage_history) > 0:
		var total_damage = 0
		var entry_num = 0
		for entry in damage_history:
			total_damage += entry["damage"]
			entry_num += 1
		var dps = total_damage/dps_damage_time
		dps = snapped(dps, 0.01)
		dps_label.text = "Dps: " +  str(dps)
		return
	dps_label.text = "" 

func _remove_old_damage_history():
	var now = Time.get_ticks_msec() 
	while damage_history.size() > 0 and (now - damage_history[0]["time"]) > dps_damage_time * 1000: #Remove Old entries
		damage_history.pop_front()
		
func _process(delta: float) -> void:
	_remove_old_damage_history()
	_calculate_dps()

func _create_damage_pop_up(damage, is_critical):
	var temp_pop_up = pop_up.instantiate()
	temp_pop_up.position = position + Vector2(0,-70)
	var pop_up_node = temp_pop_up.get_child(0)
	pop_up_node.text = str(damage)
	if is_critical:
		pop_up_node.add_theme_color_override("font_color", Color(1, 0, 0))
	get_tree().root.add_child(temp_pop_up)

func take_damage(damage, is_critical):
	$AnimatedSprite2D.play('hit')
	_add_to_damage_history(damage)
	_create_damage_pop_up(damage, is_critical)

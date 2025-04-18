extends Area2D

var pop_up: PackedScene = preload("res://Objects/Other/damagePopUp.tscn")

@onready var dps_label = $Dps
var damage_history = []
var dps = 0
var dps_damage_time = 5.0

func play_anim():
	$AnimatedSprite2D.play('hit')

func _on_animated_sprite_2d_animation_looped() -> void:
	$AnimatedSprite2D.stop()

func add_to_damage_history(damage):
	var now = Time.get_ticks_msec() 
	damage_history.append({"time": now, "damage": damage})

func _calculate_dps():
	if len(damage_history) > 0:
		var total_damage = 0
		var entry_num = 0
		for entry in damage_history:
			total_damage += entry["damage"]
			entry_num += 1
		var dps = total_damage/entry_num
		dps = round(dps)
		dps_label.text = "Dps: " +  str(dps)
		return
	dps_label.text = "Dps: 0" 

func _remove_old_damage_history():
	var now = Time.get_ticks_msec() 
	while damage_history.size() > 0 and (now - damage_history[0]["time"]) > dps_damage_time * 1000: #Remove Old entries
		damage_history.pop_front()
		
func _process(delta: float) -> void:
	_remove_old_damage_history()
	_calculate_dps()

func create_damage_pop_up(damage):
	var tempPopUp = pop_up.instantiate()
	tempPopUp.position = position + Vector2(0,-70)
	tempPopUp.get_child(0).text = str(damage)
	get_tree().root.add_child(tempPopUp)

func display_damage(damage):
	add_to_damage_history(damage)
	create_damage_pop_up(damage)

extends CharacterBody2D

@export var current_speed: int = 250
@export var max_hp: int = 100
@onready var current_hp: int = max_hp
@onready var health_bar: ProgressBar = $HealthBar

var pop_up: PackedScene = preload("res://scenes/UI/damage_pop_up.tscn")

func _ready() -> void:
	health_bar.max_value = max_hp
	health_bar.value = current_hp


func _create_damage_pop_up(damage, is_critical):
	var temp_pop_up = pop_up.instantiate()
	temp_pop_up.position = position + Vector2(0,-70)
	var pop_up_node = temp_pop_up.get_child(0)
	pop_up_node.text = str(damage)
	if is_critical:
		pop_up_node.add_theme_color_override("font_color", Color(1, 0, 0))
	get_tree().root.add_child(temp_pop_up)
	
func take_damage(damage, is_critical):
	#$AnimatedSprite2D.play('hit')
	current_hp = current_hp - damage
	health_bar.value = current_hp
	_create_damage_pop_up(damage, is_critical)
	if current_hp <= 0:
		queue_free()

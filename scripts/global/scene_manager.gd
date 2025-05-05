extends Node

var current_dungeon = -1
var dungeon_levels = []

func _ready() -> void:
	dungeon_levels.append(load("res://scenes/places/dungeon_1.tscn"))

func load_next_dungeon():
	if len(dungeon_levels) - 1 > current_dungeon:
		current_dungeon += 1
		get_tree().change_scene_to_packed(dungeon_levels[current_dungeon])

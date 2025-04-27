extends Node

var weapon_stats = {}
var keys_stats = []

var weapons_scenes = {}
var keys_scenes = []

func load_weapon_stats():
	weapon_stats['Sword'] = load('res://Scenes/Resources/Weapons/Tier1/Sword.tres')
	weapon_stats['WaterWand'] = load('res://Scenes/Resources/Weapons/Tier1/WaterWand.tres')
	weapon_stats['VoidOrb'] = load('res://Scenes/Resources/Weapons/Tier1/VoidOrb.tres')
	weapon_stats['Shotgun'] = load('res://Scenes/Resources/Weapons/Tier1/Shotgun.tres')
	keys_stats = weapon_stats.keys()

func load_weapon_scenes():
	weapons_scenes['Sword'] = load('res://Scenes/Weapons/Tier1/Sword/Sword.tscn')
	weapons_scenes['WaterWand'] = load('res://Scenes/Weapons/Tier1/WaterWand/WaterWand.tscn')
	weapons_scenes['VoidOrb'] = load('res://Scenes/Weapons/Tier1/VoidOrb/VoidOrb.tscn')
	weapons_scenes['Shotgun'] = load('res://Scenes/Weapons/Tier1/Shotgun/Shotgun.tscn')
	keys_scenes = weapons_scenes.keys()
	
func key_to_keyindex(key):
	for i in keys_stats.size():
		if key == keys_stats[i]:
			return i
	return -1
	
func give_next_keyindex(index):
	if index >= keys_stats.size() - 1:
		return 0
	return index + 1
	
func _ready() -> void:
	load_weapon_stats()
	load_weapon_scenes()

extends Node

var weapon_stats = {}
var keys_stats = []

var weapons_scenes = {}
var keys_scenes = []

func load_weapon_stats():
	weapon_stats['Sword'] = load('res://resources/weapons/tier_1/sword.tres')
	weapon_stats['WaterWand'] = load('res://resources/weapons/tier_1/water_wand.tres')
	weapon_stats['VoidOrb'] = load('res://resources/weapons/tier_1/void_orb.tres')
	weapon_stats['Shotgun'] = load('res://resources/weapons/tier_1/shotgun.tres')
	keys_stats = weapon_stats.keys()

func load_weapon_scenes():
	weapons_scenes['Sword'] = load('res://scenes/weapons/tier_1/sword/sword.tscn')
	weapons_scenes['WaterWand'] = load('res://scenes/weapons/tier_1/water_wand/water_wand.tscn')
	weapons_scenes['VoidOrb'] = load('res://scenes/weapons/tier_1/void_orb/void_orb.tscn')
	weapons_scenes['Shotgun'] = load('res://scenes/weapons/tier_1/shotgun/shotgun.tscn')
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

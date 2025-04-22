extends Node

var weapons = {}
var keys = []

func load_weapons():
	weapons['Sword'] = load('res://Scenes/Resources/Weapons/Tier1/Sword.tres')
	weapons['WaterWand'] = load('res://Scenes/Resources/Weapons/Tier1/WaterWand.tres')
	weapons['VoidOrb'] = load('res://Scenes/Resources/Weapons/Tier1/VoidOrb.tres')
	keys = weapons.keys()

func key_to_keyindex(key):
	for i in keys.size():
		if key == keys[i]:
			return i
	return -1
	
func give_next_keyindex(index):
	if index >= keys.size() - 1:
		return 0
	return index + 1

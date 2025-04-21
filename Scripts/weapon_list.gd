extends Node

var weapons = {}
var keys = []
func load_weapons():
	weapons['swordObject'] = load('res://Objects/Weapons/Melee/Tier1/Sword.tscn')
	weapons['waterWandObject'] = load('res://Objects/Weapons/Magic/Tier1/WaterWand.tscn')
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

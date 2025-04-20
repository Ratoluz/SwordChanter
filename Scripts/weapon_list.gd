extends Node

var weapons = {}
var keys = []
func load_weapons():
	weapons['swordObject'] = load('res://Objects/Weapons/Tier1/swordObject.tscn')
	weapons['waterWandObject'] = load('res://Objects/Weapons/Tier1/waterWandObject.tscn')
	keys = weapons.keys()
	print(keys)

func key_to_keyindex(key):
	for i in keys.size():
		if key == keys[i]:
			return i
	return -1
	
func give_next_keyindex(index):
	print(index)
	print(keys.size())
	if index >= keys.size() - 1:
		return 0
	return index + 1
		
#func name_to_index(name):
#	for i in weapons.size():

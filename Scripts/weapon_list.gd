extends Node

var weapons: Array = []

func load_weapons():
	weapons.append(load('res://Objects/Weapons/Tier1/swordObject.tscn'))
	weapons.append(load('res://Objects/Weapons/Tier1/waterWandObject.tscn'))

func name_to_index(name):
	for i in weapons.size():
		var tempWeapon = weapons[i].instantiate()
		add_child(tempWeapon)
		print(tempWeapon.weapon.weapon_name)
		if name == tempWeapon.weapon.weapon_name:
			tempWeapon.queue_free()
			return i
		tempWeapon.queue_free()
	return -1

extends Node

var weapon_array: Array = []

func load_weapons():
	weapon_array.append(load('res://Objects/Weapons/Tier1/swordObject.tscn'))
	weapon_array.append(load('res://Objects/Weapons/Tier1/waterWandObject.tscn'))

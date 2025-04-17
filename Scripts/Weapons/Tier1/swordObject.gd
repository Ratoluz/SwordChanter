extends Area2D

var weapon: Sword = preload("res://Scripts/Weapons/Tier1/sword.gd").new()

func _ready() -> void:
	var tempTimer = Timer.new()
	add_child(tempTimer)
	weapon.timer = tempTimer

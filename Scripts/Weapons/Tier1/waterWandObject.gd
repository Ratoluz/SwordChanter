extends Area2D

var weapon = preload("res://Scripts/weapon.gd").new()
	
func _ready() -> void:
	$/root/Main/WeaponManager.assign_references(weapon)
	weapon.projectile = load("res://Objects/Weapons/Projectiles/waterWandProjectile.tscn")
	weapon.projectileSpeed = 1300
	weapon.damage = 1
	weapon.cooldown = 0.1
	weapon.spread = 12
	weapon.auto_swing = true

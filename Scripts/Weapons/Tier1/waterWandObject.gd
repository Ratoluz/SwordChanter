extends Area2D

var weapon = preload("res://Scripts/weapon.gd").new()

func _ready() -> void:
	weapon.timer = $/root/Main/Player/WeaponManager/Timer
	weapon.projectile_parent = $/root/Main/projectileParent
	weapon.weaponManager = $/root/Main/Player/WeaponManager
	#weapon.projectile = load("res://Objects/Weapons/Projectiles/waterWandProjectile.tscn")
	weapon.projectile = load("res://Objects/Weapons/Projectiles/waterWandProjectile.tscn")
	weapon.projectileSpeed = 1300
	weapon.damage = 1
	weapon.cooldown = 0.1
	weapon.spread = 12

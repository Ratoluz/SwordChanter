extends Area2D

var weapon = preload("res://Scripts/weapon.gd").new()

func _ready() -> void:
	weapon.timer = $/root/Main/Player/WeaponManager/Timer
	weapon.projectile_parent = $/root/Main/projectileParent
	weapon.projectile = load("res://Objects/Weapons/Projectiles/swordProjectile.tscn")
	weapon.weaponManager = $/root/Main/Player/WeaponManager
	weapon.projectileSpeed = 1300
	weapon.damage = 12
	weapon.cooldown = 0.3

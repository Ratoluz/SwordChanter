extends Area2D

var weapon: Sword = preload("res://Scripts/Weapons/Tier1/sword.gd").new()

func _ready() -> void:
	weapon.timer = $/root/Main/Player/WeaponManager/Timer
	weapon.customAddChild = $/root/Main/CustomAddChild
	weapon.projectile = load("res://Objects/Weapons/Projectiles/swordProjectile.tscn")
	weapon.weaponManager = $/root/Main/Player/WeaponManager
	weapon.projectileSpeed = 1300
	weapon.damage = 10
	weapon.cooldown = 0.3

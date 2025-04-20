extends Area2D

var weapon = preload("res://Scripts/weapon.gd").new()

func _ready() -> void:
	$/root/Main/WeaponManager.assign_references(weapon)
	weapon.projectile = load("res://Objects/Weapons/Projectiles/swordProjectile.tscn")
	weapon.projectileSpeed = 1300
	weapon.damage = 12
	weapon.cooldown = 0.3
	weapon.weapon_name = 'Sword'

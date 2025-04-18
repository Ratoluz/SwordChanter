extends Area2D

var weapon: Sword = preload("res://Scripts/Weapons/Tier1/sword.gd").new()

func _ready() -> void:
	var tempTimer = Timer.new()
	add_child(tempTimer)
	weapon.timer = tempTimer
	
	weapon.projectile = load("res://Objects/Weapons/Projectiles/swordProjectile.tscn")
	weapon.weaponManager = $/root/Main/Player/WeaponManager
	weapon.customAddChild = $/root/Main/CustomAddChild
	weapon.projectileSpeed = 1100

class_name Sword 
extends Weapon

var projectile 
var weaponManager
var projectileSpeed 
var tempProjectile
var customAddChild

func _perform_attack():
	tempProjectile = projectile.instantiate()
	customAddChild.custom_add_child(tempProjectile)
	tempProjectile.position = weaponManager.currentWeapon.position
	tempProjectile.angle = weaponManager.angle 
	tempProjectile.speed = projectileSpeed
	
	

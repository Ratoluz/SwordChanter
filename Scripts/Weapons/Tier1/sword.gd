class_name Sword 
extends Weapon

func _perform_attack():
	var tempProjectile = projectile.instantiate()
	customAddChild.custom_add_child(tempProjectile)
	
	tempProjectile.position = weaponManager.currentWeapon.position
	tempProjectile.angle = weaponManager.angle 
	tempProjectile.speed = projectileSpeed
	tempProjectile.damage = damage
	

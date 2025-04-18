class_name Sword 
extends Weapon

func _perform_attack():
	_critical_damage()
	var tempProjectile = projectile.instantiate()
	customAddChild.custom_add_child(tempProjectile)
	
	tempProjectile.position = weaponManager.currentWeapon.position
	tempProjectile.angle = weaponManager.angle 
	tempProjectile.speed = projectileSpeed
	tempProjectile.damage = current_damage
	tempProjectile.is_critical = is_critical
	

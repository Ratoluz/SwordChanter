extends Weapon
var projectile_2_angle: float
var projectile_2: PackedScene
func _set_custom_stats(stats):
	projectile_2_angle = stats.projectile_2_angle
	projectile_2 = stats.projectile_2
func _set_projectile_stats(tempProjectile):
	tempProjectile.projectile_2_angle = projectile_2_angle
	tempProjectile.projectile_2 = projectile_2
	tempProjectile.critical_chance_multiplier = critical_chance_multiplier
	

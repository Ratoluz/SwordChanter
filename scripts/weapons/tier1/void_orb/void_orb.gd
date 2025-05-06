extends Weapon
var projectile_2_angle: float
var projectile_2: PackedScene

func _set_custom_stats(stats):
	projectile_2_angle = stats.projectile_2_angle
	projectile_2 = stats.projectile_2
	
func _set_projectile_stats_custom(temp_projectile):
	temp_projectile.projectile_2_angle = projectile_2_angle
	temp_projectile.projectile_2 = projectile_2
	temp_projectile.critical_chance_multiplier = critical_chance_multiplier

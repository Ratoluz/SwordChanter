extends Projectile

var projectile_template = preload('res://scenes/weapons/projectile_template.tscn')
#var player
var projectile_2_angle: float
var projectile_2_stats: ProjectileStats

func _set_projectile2_stats(temp_projectile, side):
	temp_projectile.set_script(projectile_2_stats.projectile_script)
	temp_projectile.position = position
	temp_projectile.angle = deg_to_rad((projectile_2_angle + rad_to_deg(rotation) + 90) + side) 
	temp_projectile.stats = projectile_2_stats
	
func _spawn_projectile(side):
	var temp_projectile = projectile_template.instantiate()
	_set_projectile2_stats(temp_projectile, side)
	$/root/Main.add_child(temp_projectile)
	temp_projectile.initialize()

	
func die():
	_spawn_projectile(0)
	_spawn_projectile(180)
	print('died')
	queue_free()

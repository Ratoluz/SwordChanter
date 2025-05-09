extends Projectile

var timer2: Timer
var projectile_template = preload('res://scenes/weapons/projectile_template.tscn')
#var player
var projectile_2_angle: float
var projectile_2_stats: ProjectileStats

func _ready() -> void:
	#player = $/root/Main/Player
	timer2 = $Timer
	timer2.start()
	timer2.timeout.connect(_on_timer_timeout)
	
func _spawn_projectile(side):
	var temp_projectile = projectile_template.instantiate()
	$/root/Main.add_child(temp_projectile)
	temp_projectile.position = position
	print( rad_to_deg(rotation) )
	temp_projectile.angle = deg_to_rad((projectile_2_angle + rad_to_deg(rotation) + 90) + side) 
	temp_projectile.speed = speed
	temp_projectile.damage = damage * critical_chance_multiplier
	temp_projectile.is_critical = true
	temp_projectile.spread = spread
	
func _on_timer_timeout():
	_spawn_projectile(0)
	_spawn_projectile(180)
	
	queue_free()

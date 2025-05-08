class_name Enemy
extends DamageTaker

enum EnemyState {CHASE, WALK_AROUND}
@export var stats: EnemyStats
var projectile: PackedScene = preload('res://scenes/enemies/enemy_projectile.tscn')
var current_hp: int 
var max_hp: int 
var speed: float 
var damage: float 
var cooldown_min: float
var cooldown_max: float
var projectile_speed: float 
var bullet_number: int
var live_time: float 
var spread: float 

var died := false
var room
var flipped := false
var can_turn := true
var state: EnemyState = EnemyState.CHASE
var rand_pos: Vector2
var can_see_player: bool

@onready var target = $"/root/Main/Player"
@onready var weapon_manager = $/root/Main/WeaponManager
@onready var health_bar: ProgressBar = $HealthBar
@onready var agent: NavigationAgent2D = $"NavigationAgent2D"
@onready var shoot_cooldown: Timer = $"ShootCooldown"
@onready var flip_cooldown: Timer = $"FlipCooldown"
@onready var pick_random_pos_cooldown: Timer = $"PickRandomPosCooldown"
@onready var animator: AnimatedSprite2D = $"AnimatedSprite2D"
@onready var raycast := $"RayCast2D"
@onready var raycast2 := $"RayCast2D2"
@onready var nav_area := $"../../"
var item_drop : PackedScene = preload("res://scenes/UI/inventory/item_drop.tscn")

func _ready() -> void:
	set_stats(stats)
	health_bar.max_value = max_hp
	health_bar.value = current_hp
	room = get_node("../../../")
	agent.target_position = target.position
	shoot_cooldown.wait_time = randf_range(cooldown_min, cooldown_max)
	
	shoot_cooldown.timeout.connect(shoot)
	flip_cooldown.timeout.connect(_on_filp_cooldown_timeout)
	
	agent.avoidance_enabled = true 
	agent.radius = 70.0 
	agent.neighbor_distance = 1000.0  
	agent.max_neighbors = 5  

func _physics_process(_delta):
	_flip()
	_enemy_AI()

func _set_projectile_stats(temp_projectile):
	speed = stats.speed
	projectile_speed = stats.projectile_speed
	temp_projectile.position = global_position / 6 
	temp_projectile.angle =  global_position.direction_to(target.global_position).angle()
	temp_projectile.speed = projectile_speed
	temp_projectile.damage = damage
	temp_projectile.spread = spread
	temp_projectile.live_time = live_time
	temp_projectile.initialize()
	_set_projectile_stats_custom(temp_projectile)

func _set_projectile_stats_custom(temp_projectile):
	pass

func set_stats(stats):
	max_hp = stats.max_health
	current_hp = stats.max_health
	damage = stats.damage
	cooldown_min = stats.cooldown_min
	cooldown_max = stats.cooldown_max
	speed = stats.speed
	agent.max_speed = 500
	bullet_number = stats.bullet_number
	live_time = stats.live_time
	spread = stats.spread
	_set_custom_stats(stats)

func _set_custom_stats(_stats):
	pass

func take_damage(damage, is_critical):
	current_hp -= damage
	health_bar.value = current_hp
	_create_damage_pop_up(damage, is_critical)
	if current_hp <= 0 and not died:
		died = true
		drop()
		room.on_enemy_death()
		queue_free()

func drop() -> void:
	if not stats or not stats.loot_table:
		return
	var dropped_items = stats.loot_table.roll_loot()
	for item_stack in dropped_items:
		if item_stack and not item_stack.is_empty():
			var drop_instance = item_drop.instantiate()
			drop_instance.initialize(item_stack, global_position / 6)
			# Add to the current scene with proper layer
			get_tree().current_scene.call_deferred("add_child", drop_instance)

func _flip():
	if not can_turn: 
		return
	if not animator.flip_h and velocity.x < 0:
		animator.flip_h = true
		flipped = true
		can_turn = false
		flip_cooldown.start()
		return
	if animator.flip_h and velocity.x > 0:
		animator.flip_h = false
		flipped = false
		can_turn = false
		flip_cooldown.start()
		
func _on_filp_cooldown_timeout():
	can_turn = true
	flip_cooldown.stop()
# ----------------ENEMY AI----------------------

func _enemy_AI():
	_set_can_see_player()
	match state:
		EnemyState.CHASE:
			_on_state_chase()
		EnemyState.WALK_AROUND:
			_on_state_walk_around()

# State Behavoiurs
func _on_state_chase():
	_follow_target(target.global_position)
	var dist_to_player = global_position.distance_to(target.global_position)
	if dist_to_player < 700 and can_see_player:
		_to_walk_around()
		_from_chase()

func _on_state_walk_around():
	if agent.is_navigation_finished():
		_pick_random_pos()
	_follow_target(rand_pos)
	var dist_to_player = global_position.distance_to(target.global_position)
	if dist_to_player > 700 or not can_see_player:
		_to_chase()
		_from_walk_around()
		
# State Transitions
func _to_walk_around():
	_pick_random_pos()
	shoot_cooldown.start()
	shoot_cooldown.wait_time = randf_range(cooldown_min, cooldown_max)
	state = EnemyState.WALK_AROUND
	print('WALK AROUND!')
	
func _from_walk_around():
	shoot_cooldown.stop()
	
func _to_chase():
	state = EnemyState.CHASE
	print('chase')
func _from_chase():
	pass

# State Actions
func _calculate_random_pos(angle, distance, deviation):
	var dir = angle
	var pos = target.global_position - Vector2(cos(dir) * distance, sin(dir) * distance)
	var random_pos = Vector2(randi_range(-deviation, deviation) + pos.x, randi_range(-deviation, deviation) + pos.y)
	return random_pos  
	
func _pick_random_pos():
	for x in range(3):
		var pos = _calculate_random_pos(global_position.direction_to(target.global_position).angle(), 400, 200) 
		print(is_point_in_navigation_area(pos))
		if _can_see_player_from_pos(pos) and is_point_in_navigation_area(pos):
			rand_pos = pos
			return
	for i in range(3):
		var pos = _calculate_random_pos(deg_to_rad(randi_range(0,360)), 400, 200)
		if _can_see_player_from_pos(pos) and is_point_in_navigation_area(pos):
			rand_pos = pos
			return
	for i in range(3):
		var pos = _calculate_random_pos(deg_to_rad(randi_range(0,360)), 100, 40)
		if _can_see_player_from_pos(pos) and is_point_in_navigation_area(pos):
			rand_pos = pos
			return

func _follow_target(pos):
	agent.target_position = pos
	var direction = global_position.direction_to(agent.get_next_path_position())
	agent.set_velocity(direction * speed) 
	var adjusted_velocity = await agent.velocity_computed
	velocity = adjusted_velocity
	move_and_slide()

func shoot():
	var temp_projectile = projectile.instantiate()
	weapon_manager.add_child(temp_projectile)
	_set_projectile_stats(temp_projectile)
	shoot_cooldown.wait_time = randf_range(cooldown_min, cooldown_max)
	
func _set_can_see_player():
	raycast.target_position = to_local(target.global_position)
	raycast.force_raycast_update()
	var collider = raycast.get_collider()

	if collider and collider.name == "Obstacles":
		can_see_player = false
		return
	can_see_player = true
	
func _can_see_player_from_pos(pos):
	raycast2.global_position = pos
	raycast2.target_position = to_local(target.global_position) 
	raycast2.force_raycast_update()
	var collider = raycast2.get_collider()

	if collider and collider.name == "Obstacles":
		return false
	return true
	
func is_point_in_navigation_area(point: Vector2) -> bool:
	var region_rid = nav_area.get_region_rid()
	var map_rid = NavigationServer2D.region_get_map(region_rid)
	var closest_point = NavigationServer2D.map_get_closest_point(map_rid, point)
	return closest_point.distance_to(point) < 1.0 

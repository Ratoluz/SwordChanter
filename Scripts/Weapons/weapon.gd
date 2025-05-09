class_name Weapon
extends Node2D

@export var stats: WeaponStats
#Public
var damage: float 
var cooldown: float 
var projectile: PackedScene 
var speed: float
var critical_chance: float
var critical_chance_multiplier: float 
var bullet_number: int
var live_time: float
var rotate_sprite: bool
var spread: float
var auto_swing: bool = false 
var sprite: Texture2D
var item_name: String
var description: String 
#Private
var weapon_manager
var timer: Timer
var current_damage: float = damage
var is_critical: bool = false
var can_attack: bool = true

func _set_custom_stats():
	pass
	
func set_stats():
	sprite = stats.sprite
	$Sprite2D.texture = sprite
	item_name = stats.item_name
	description = stats.description
	damage = stats.damage
	cooldown = stats.cooldown
	projectile = stats.projectile
	speed = stats.speed
	critical_chance = stats.critical_chance
	critical_chance_multiplier = stats.critical_chance_multiplier
	bullet_number = stats.bullet_number
	live_time = stats.live_time
	rotate_sprite = stats.rotate_sprite
	spread = stats.spread
	auto_swing = stats.auto_swing
	_set_custom_stats()
	
func _set_references():
	weapon_manager = $"../"
	timer = weapon_manager.get_node('Timer')
	
func _ready() -> void:
	_set_references()
	set_stats()
	_set_custom_stats()
	
func _critical_damage():
	var rand = randf_range(0, 1.0)
	if rand < critical_chance:
		current_damage = damage * critical_chance_multiplier
		is_critical = true
		return
	current_damage = damage 
	is_critical = false

func attack():
	if can_attack:
		for i in range(bullet_number):
			_perform_attack()
		can_attack = false
		
		timer.wait_time = cooldown
		timer.start()
		await(timer.timeout)
		
		can_attack = true

func _set_projectile_stats(temp_projectile):
	temp_projectile.position = weapon_manager.player.position
	temp_projectile.angle = weapon_manager.angle 
	temp_projectile.speed = speed
	temp_projectile.damage = current_damage
	temp_projectile.is_critical = is_critical
	temp_projectile.spread = spread
	temp_projectile.live_time = live_time
	temp_projectile.rotate_sprite = rotate_sprite
	_set_projectile_stats_custom(temp_projectile)
	
func _set_projectile_stats_custom(temp_projectile):
	pass

func _perform_attack():
	_critical_damage()
	var temp_projectile = projectile.instantiate()
	weapon_manager.add_child(temp_projectile)
	_set_projectile_stats(temp_projectile)
	temp_projectile.initialize()

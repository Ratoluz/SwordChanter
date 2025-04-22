class_name Weapon
extends Node2D

#Public
var damage: float 
var cooldown: float 
var projectile: PackedScene 
var projectileSpeed: float
var critical_chance: float
var critical_chance_multiplier: float 
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

func _set_custom_stats(stats):
	pass
func set_stats(stats):
	sprite = stats.sprite
	$Sprite2D.texture = sprite
	item_name = stats.item_name
	description = stats.description
	damage = stats.damage
	cooldown = stats.cooldown
	projectile = stats.projectile
	projectileSpeed = stats.projectileSpeed
	critical_chance = stats.critical_chance
	critical_chance_multiplier = stats.critical_chance_multiplier
	spread = stats.spread
	auto_swing = stats.auto_swing
	_set_custom_stats(stats)
	
func _set_references():
	weapon_manager = $/root/Main/WeaponManager
	timer = weapon_manager.get_node('Timer')
	
func _ready() -> void:
	_set_references()
	
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
		_perform_attack()
		can_attack = false
		
		timer.wait_time = cooldown
		timer.start()
		await(timer.timeout)
		
		can_attack = true

func _set_projectile_stats(tempProjectile):
	pass
func _perform_attack():
	_critical_damage()
	var tempProjectile = projectile.instantiate()
	weapon_manager.add_child(tempProjectile)
	tempProjectile.position = weapon_manager.player.position
	tempProjectile.angle = weapon_manager.angle 
	tempProjectile.speed = projectileSpeed
	tempProjectile.damage = current_damage
	tempProjectile.is_critical = is_critical
	tempProjectile.spread = spread
	_set_projectile_stats(tempProjectile)
	tempProjectile.initialize()

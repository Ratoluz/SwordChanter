class_name Weapon
extends Area2D

var damage: float = 10
var current_damage: float = damage
var cooldown: float = 0.5
var projectile: PackedScene 
var projectileSpeed: float = 1000
var critical_chance: float = 0.3
var critical_chance_multiplier: float = 1.3
var spread: float = 0
var is_critical: bool = false
var auto_swing: bool = false 
var can_attack: bool = true
var weapon_name: String

var weapon_manager
var timer: Timer
	
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
	tempProjectile.initialize()

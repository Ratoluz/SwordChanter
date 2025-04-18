class_name Weapon
extends Area2D

var damage: float = 10
var cooldown: float = 0.5
var projectile: PackedScene 
var projectileSpeed: float = 1000
var weaponManager
var customAddChild

var can_attack: bool = true
var timer: Timer

func attack():
	if can_attack:
		_perform_attack()
		can_attack = false
		
		timer.wait_time = cooldown
		timer.start()
		await(timer.timeout)
		
		can_attack = true
		print('can attack again')

func _perform_attack():
	print('attack not overrided')

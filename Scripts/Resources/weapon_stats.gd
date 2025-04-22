class_name WeaponStats
extends ItemStats

@export var custom_script: Script
@export var damage: float = 10
@export var cooldown: float = 0.5
@export var projectile: PackedScene 
@export var speed: float = 1000
@export var critical_chance: float = 0.3
@export var critical_chance_multiplier: float = 1.3
@export var bullet_number = 1
@export var live_time: float = 2
@export var rotate_sprite: bool = false
@export var auto_swing: bool = false 
@export var spread: float = 0
@export var distance_from_player: float = 50

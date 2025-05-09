extends Node
# weapons id range 1-999; material id range 1000-1999
const SWORD = 1 
const WATER_WAND = 2
const VOID_ORB = 3
const SHOTGUN = 4
const RUBY = 1000

var items: Dictionary[int, Resource] = {
	SWORD: load('res://resources/weapons/tier_1/sword.tres'),
	WATER_WAND: load('res://resources/weapons/tier_1/water_wand.tres'),
	VOID_ORB: load('res://resources/weapons/tier_1/void_orb.tres'),
	SHOTGUN: load('res://resources/weapons/tier_1/shotgun.tres'),
	RUBY: load('res://resources/materials/ruby.tres')
}

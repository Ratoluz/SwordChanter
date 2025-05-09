extends Node
# weapons id range 1-999; material id range 1000-1999
const SWORD = 1 
const WATER_WAND = 2
const VOID_ORB = 3
const SHOTGUN = 4
const RUBY = 1000

var items: Dictionary[int, Resource] = {
	SWORD: preload('res://resources/weapons/tier_1/sword.tres'),
	WATER_WAND: preload('res://resources/weapons/tier_1/water_wand.tres'),
	VOID_ORB: preload('res://resources/weapons/tier_1/void_orb.tres'),
	SHOTGUN: preload('res://resources/weapons/tier_1/shotgun.tres'),
	RUBY: preload('res://resources/materials/ruby.tres')
}

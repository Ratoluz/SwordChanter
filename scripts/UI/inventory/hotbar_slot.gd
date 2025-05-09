class_name HotbarSlot
extends Slot

@onready var weapon_manager = $"../../../../WeaponManager"

func on_set_as_active():
	if item is WeaponStats:
		weapon_manager.equip_weapon(item)

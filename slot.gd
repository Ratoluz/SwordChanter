extends Panel

@export var item: ItemStats = null
@export var amount: int = 0

func _ready():
	update_slot()

func update_slot():
	if item == null or amount <= 0:
		$Icon.texture = null
		$Amount.text = ""
	else:
		$Icon.texture = item.sprite
		$Amount.text = str(amount)

func set_slot(new_item: ItemStats, new_amount: int):
	item = new_item
	amount = new_amount
	update_slot()

func clear_slot():
	item = null
	amount = 0
	update_slot()

func _get_drag_data(at_position):
	if item == null:
		return null

	var preview_texture = TextureRect.new()
	preview_texture.texture = item.sprite
	preview_texture.size = Vector2(16, 16)
	preview_texture.position = -Vector2(8, 8)
	preview_texture.scale = Vector2(5, 5)
	preview_texture.z_index = 100

	var preview = Control.new()
	preview.add_child(preview_texture)
	set_drag_preview(preview)

	return {
		"item": item,
		"amount": amount,
		"source_slot": self
	}

func _can_drop_data(at_position, data):
	return data.has("item") and data.has("amount") and data.has("source_slot")

func _drop_data(at_position, data):
	if not (data.has("item") and data.has("amount") and data.has("source_slot")):
		return

	var source_slot = data.source_slot

	if source_slot == self:
		return

	# Save current values
	var temp_item = item
	var temp_amount = amount

	# Set this slot with the dragged data
	set_slot(data.item, data.amount)

	# Set source slot with previous values
	source_slot.set_slot(temp_item, temp_amount)

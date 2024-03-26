extends Panel

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item
@onready var amountLabel: Label = $CenterContainer/Panel/amount

func update(slot: InventorySlot):
	if !slot.item:
		backgroundSprite.frame = 0
		itemSprite.hide()
		amountLabel.hide()
		return
	backgroundSprite.frame = 1
	itemSprite.texture = slot.item.texture
	itemSprite.show()
	if slot.amount == 1:
		amountLabel.hide()
		return
	amountLabel.show()
	amountLabel.text = str(slot.amount)

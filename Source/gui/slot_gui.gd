extends Panel

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item

func update(item: InventoryItem):
	if !item:
		backgroundSprite.frame = 0
		itemSprite.hide()
		return
	backgroundSprite.frame = 1
	itemSprite.texture = item.texture
	itemSprite.show()

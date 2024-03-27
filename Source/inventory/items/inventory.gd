extends Resource

class_name Inventory

signal updated

@export var slots: Array[InventorySlot]

func insert(item: InventoryItem):
	# Cherche d'abord un slot avec l'item qui n'est pas plein.
	var itemSlots = slots.filter(func(slot): return slot.item == item and slot.amount < item.max_amount_per_stack)
	
	if itemSlots:
		# Si trouvé, augmente la quantité de 1.
		itemSlots[0].amount += 1
	else:
		# Sinon, cherche un slot vide.
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if emptySlots:
				# Si un slot vide est trouvé, initialise l'item et la quantité à 1.
			emptySlots[0].item = item
			emptySlots[0].amount = 1

	updated.emit()


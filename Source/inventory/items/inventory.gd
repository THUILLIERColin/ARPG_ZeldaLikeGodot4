extends Resource

class_name Inventory

signal updated

@export var slots: Array[InventorySlot]

func insert_in_empty_slot(item: InventoryItem):
	var emptySlots = slots.filter(func(slot): return slot.item == null) # filtre les slots vides
	if !emptySlots.is_empty():
		emptySlots[0].item = item
		emptySlots[0].amount = 1

func insert2(item: InventoryItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item) # filtre les slots qui contiennent l'item
	if !itemSlots.is_empty():
		if itemSlots[0].amount < item.max_amount_per_stack:
			itemSlots[0].amount += 1
		else:
			insert_in_empty_slot(item)
	else:
		insert_in_empty_slot(item)
	
	updated.emit()

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


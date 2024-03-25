extends HBoxContainer

@onready var HeartGuiClass = preload("res://gui/heart_gui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setMaxHearts(maxHearts: int):
	for i in range(maxHearts):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)


func updateHearts(currentHearts: int):
	var hearts = get_children()
	
	print_debug(hearts.size())
	for i in range(hearts.size()):
		print_debug(hearts[i])

	for i in range(currentHearts):
		hearts[i].update(true)
	
	for i in range(currentHearts, hearts.size()):
		hearts[i].update(false)
	

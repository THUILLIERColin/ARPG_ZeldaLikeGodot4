extends Node2D

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	heartsContainer.setMaxHearts(player.max_health)
	heartsContainer.updateHearts(player.current_health)
	player.health_change.connect(heartsContainer.updateHearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_inventory_gui_closed():
	get_tree().paused = false


func _on_inventory_gui_opended():
	get_tree().paused = true

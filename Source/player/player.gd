extends CharacterBody2D

@export var speed: int = 75
@onready var animations = $AnimationPlayer

func handleInput():
	var move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = move_direction*speed

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing(): animations.stop()
		return
	var direction = "Down"
	if velocity.x < 0: direction = "Left"
	elif velocity.x > 0: direction = "Right"
	elif velocity.y < 0: direction = "Up"

	animations.play("walk" + direction)
	

func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()


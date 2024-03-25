extends CharacterBody2D

signal health_change

@export var speed: int = 75
@onready var animations = $AnimationPlayer

@export var max_health: int = 3
@onready var current_health: int = max_health

func handleInput():
	var move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = move_direction.normalized()*speed

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
	# velocity = velocity * delta
	updateAnimation()
	move_and_slide()


func _on_damages_box_area_entered(area):
	if area.name == "HitBox":
		current_health -= 1
		if current_health <= 0:
			current_health = max_health
		
		health_change.emit(current_health)

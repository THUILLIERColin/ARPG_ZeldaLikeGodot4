extends CharacterBody2D

@export var speed: int = 75
@onready var animations = $AnimationPlayer

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
	
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug("Collided with: " + collider.name)
	

func _physics_process(delta):
	handleInput()
	# velocity = velocity * delta
	updateAnimation()
	handleCollision()
	move_and_slide()

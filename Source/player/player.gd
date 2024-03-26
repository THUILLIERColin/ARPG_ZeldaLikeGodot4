extends CharacterBody2D

signal health_change

@export var speed: int = 75
@onready var animations = $AnimationPlayer
@onready var effects_animations = $Effects
@onready var hurtTimer = $HurtTimer

@export var max_health: int = 3
@onready var current_health: int = max_health

@export var knockback_power: int = 500

func _ready():
	effects_animations.play("RESET")

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
		knockback(area.get_parent().velocity)
		effects_animations.play("hurtBlink")
		hurtTimer.start()
		await hurtTimer.timeout
		effects_animations.play("RESET")

func knockback(enemy_velocity: Vector2):
	var knockback_direction = (enemy_velocity - velocity).normalized() * knockback_power
	velocity = knockback_direction
	move_and_slide() 

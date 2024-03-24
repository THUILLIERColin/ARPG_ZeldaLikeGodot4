extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

@onready var animation = $AnimatedSprite2D

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = endPoint.global_position

func changeDirection():
	var tempEndPosition = endPosition
	endPosition = startPosition
	startPosition = tempEndPosition

func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		position = endPosition
		changeDirection()
	velocity = moveDirection.normalized()*speed

func updateAnimation():
	var animationDirection = "Up"
	if velocity.y > 0:
		animationDirection = "Down"
	elif velocity.x > 0:
		animationDirection = "Right"
	elif velocity.x < 0:
		animationDirection = "Left"
	
	animation.play("walk" + animationDirection)

func _physics_process(delta):
	updateVelocity()
	updateAnimation()
	move_and_slide()

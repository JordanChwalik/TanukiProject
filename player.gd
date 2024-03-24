extends Area2D

@export var speed = 400
var screen_size
var direction
var currently_acting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()
	direction = "down"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x > 0 and velocity.y == 0:
		$AnimatedSprite2D.animation = "walk_right"
		direction = "right"
	elif velocity.x < -1 and velocity.y == 0:
		$AnimatedSprite2D.animation = "walk_left"
		direction = "left"
	elif velocity.y > 0 and velocity.x == 0:
		$AnimatedSprite2D.animation = "walk_down"
		direction = "down"
	elif velocity.y < 0 and velocity.x == 0:
		$AnimatedSprite2D.animation = "walk_up"
		direction = "up"
	elif velocity.x > 0 and velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_up_right"
		direction = "up_right"
	elif velocity.x > 0 and velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down_right"
		direction = "down_right"
	elif velocity.x < 0 and velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_up_left"
		direction = "up_left"
	elif velocity.x < 0 and velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down_left"
		direction = "down_left"
	
	if Input.is_action_just_pressed("light_attack"):
		light_attack()
	
	if Input.is_action_just_pressed("heavy_attack"):
		heavy_attack()
		

func light_attack():
	print("light_" + direction)
	currently_acting = true
	await get_tree().create_timer(0.25).timeout
	
	
func heavy_attack():
	print("heavy_" + direction)


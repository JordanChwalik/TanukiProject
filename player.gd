extends CharacterBody2D


@export var speed = 300.0
var direction = "down"
var currently_attacking = false
var light_attack_cooldown = 0.3
var heavy_attack_cooldown = 0.75
var failed_magic_cooldown = 0.25
var stored_spells = []

func _physics_process(delta):
	# Handle movement
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	
	velocity = input_vector.normalized() * speed
	
	if not currently_attacking:
		play_direction_animation()
	move_and_slide()
	
	# Check for attack inputs
	if Input.is_action_just_pressed("light_attack") and not currently_attacking:
		light_attack()
	if Input.is_action_just_pressed("heavy_attack") and not currently_attacking:
		heavy_attack()
	if Input.is_action_just_pressed("cast_spell") and not currently_attacking:
		use_magic()

func light_attack():
	print("Light attack start")
	currently_attacking = true
	$LightAttackBox.disabled = false
	$AttackBox.visible = true
	await get_tree().create_timer(light_attack_cooldown).timeout
	print("Light attack ended")
	currently_attacking = false
	$LightAttackBox.disabled = true
	$AttackBox.visible = false

func heavy_attack():
	print("Heavy attack start")
	currently_attacking = true
	$LightAttackBox.disabled = false
	await get_tree().create_timer(heavy_attack_cooldown).timeout
	print("Heavy attack ended")
	currently_attacking = false
	$LightAttackBox.disabled = true

func use_magic():
	print("Casting spell")
	if stored_spells.is_empty():
		currently_attacking = true
		await get_tree().create_timer(failed_magic_cooldown).timeout
		print("No spells slotted")
	else:
		print("Spell successful")
	currently_attacking = false
		

func play_direction_animation():
	if velocity.x > 0 and velocity.y == 0:
		$AnimatedSprite2D.animation = "walk_right"
		direction = "right"
		$AttackBox.position = Vector2(400, 0)
		$AttackBox.rotation_degrees = 90
		
	elif velocity.x < -1 and velocity.y == 0:
		$AnimatedSprite2D.animation = "walk_left"
		direction = "left"
		$AttackBox.position = Vector2(-400, 0)
		$AttackBox.rotation_degrees = -90
		
	elif velocity.y > 0 and velocity.x == 0:
		$AnimatedSprite2D.animation = "walk_down"
		direction = "down"
		$AttackBox.position = Vector2(0, 400)
		$AttackBox.rotation_degrees = 180
		
	elif velocity.y < 0 and velocity.x == 0:
		$AnimatedSprite2D.animation = "walk_up"
		direction = "up"
		$AttackBox.position = Vector2(0, -400)
		$AttackBox.rotation_degrees = 0
		
	elif velocity.x > 0 and velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_up_right"
		direction = "up_right"
		$AttackBox.position = Vector2(300, -300)
		$AttackBox.rotation_degrees = 45
		
	elif velocity.x > 0 and velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down_right"
		direction = "down_right"
		$AttackBox.position = Vector2(300, 300)
		$AttackBox.rotation_degrees = 135
		
	elif velocity.x < 0 and velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_up_left"
		direction = "up_left"
		$AttackBox.position = Vector2(-300, -300)
		$AttackBox.rotation_degrees = -45
		
	elif velocity.x < 0 and velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down_left"
		direction = "down_left"
		$AttackBox.position = Vector2(-300, 300)
		$AttackBox.rotation_degrees = -135
	

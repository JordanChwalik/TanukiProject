extends RigidBody2D

var element = "fire"
var speed = 3000
@export var damage = 5
@export var max_distance = 6000
var start_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = get_global_position()
	var element_direction = Vector2(1, 0)
	apply_impulse(element_direction * speed, start_position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_global_position().distance_to(start_position) >= max_distance:
		queue_free()
	pass

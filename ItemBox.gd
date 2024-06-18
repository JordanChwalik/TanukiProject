extends Area2D
signal player_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_entered(area):
	player_hit.emit()
	print("Collision Detected!")
	call_deferred("free")
	pass # Replace with function body.

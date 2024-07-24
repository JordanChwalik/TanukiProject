extends Node2D
signal collect_spell

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Item Box Created")
	
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	emit_signal("collect_spell")
	print("Item box detects collision")
	queue_free()
	pass # Replace with function body.

extends Area2D

#signal 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	if (body_shape == 0):
		print("Body")
		body.queue_free()
	elif (body_shape == 1):
		print("Feet")
		queue_free()
	#print(body.name)
	#print(body_shape)
	pass # Replace with function body.

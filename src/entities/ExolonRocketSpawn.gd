extends Entity

var onscreen = false


func _on_VisibilityNotifier2D_screen_entered():
	onscreen = true
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	onscreen = false
	pass # Replace with function body.


func _on_Timer_timeout():
	if onscreen:
		var scene = load("res://entities/ExolonRocketEntity.tscn")
		var bullet = scene.instance()
		add_child(bullet)
		
	pass # Replace with function body.

extends Component

var on_screen = false

func _on_RemoveWhenOffScreenComponent_screen_entered():
	on_screen = true;
	pass # Replace with function body.


func _on_RemoveWhenOffScreenComponent_screen_exited():
	if on_screen:
		ECS.remove_entity(get_owner())
		#print("Entity removed")
	pass # Replace with function body.

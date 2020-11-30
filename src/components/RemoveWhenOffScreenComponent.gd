extends Component

var on_screen = false

func _on_RemoveWhenOffScreenComponent_screen_entered():
	on_screen = true;
	pass


func _on_RemoveWhenOffScreenComponent_screen_exited():
	if on_screen:
		var owner = get_owner()
		ECS.remove_entity(owner)
	pass

extends System

func on_process_entity(entity : Entity, delta: float):
	if entity == null:
		return

	var rem : CheckIfOnScreenComponent = ECS.entity_get_component(entity, "checkifonscreencomponent")
	if rem.on_screen == false and rem.been_on_screen:
		ECS.remove_entity(entity)
		
	#var main = get_tree().get_root().get_node("Main")
	#var v = main.get_viewport()
	#var cam = main.get_node("Camera2D")
	
	#print(cam.get_camera_position())
	#var rem =  ECS.entity_get_component(entity, "removewhenoffscreencomponent")
	#var dist = cam.get_camera_position().distance_to(entity.position)
	#rem.on_screen = dist < 1000
	#if rem.on_screen == false:
	#	print("off screen!")
	#else:
	#	print("ON screen!")
		
	pass

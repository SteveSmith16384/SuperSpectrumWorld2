extends System

func on_process_entity(entity : Entity, delta: float):
	if entity == null:
		return

	var main = get_tree().get_root().get_node("Main")
	var v = main.get_viewport()
	var cam = main.get_node("Camera2D")
	
	#print(cam.get_camera_position())
	var rem : CheckIfOnScreenComponent = ECS.entity_get_component(entity, "checkifonscreencomponent")
	var cam_pos : Vector2 = cam.get_camera_position()
	var e_pos : Vector2 = entity.global_position#get_node("Sprite").get_global_pos()
	#var dist = cam_pos.distance_to(e_pos)
	var dist = e_pos.x - cam_pos.x
	rem.on_screen = dist > -550 # todo - inc to 550
	if rem.on_screen == false:
		print("Removing " + entity.get_class())
		ECS.remove_entity(entity)
	pass

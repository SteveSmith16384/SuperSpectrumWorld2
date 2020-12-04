class_name CheckIfOnScreenSystem
extends System

func on_process_entity(entity : Entity, delta: float):
	if entity == null:
		return

	var main = get_tree().get_root().get_node("Main")
	var v = main.get_viewport()
	var cam = main.get_node("Camera2D")
	
	#print(cam.get_camera_position())
	var rem : CheckIfOnScreenComponent = ECS.entity_get_component(entity, "checkifonscreencomponent")
	var cam_pos = cam.get_camera_position()
	#print(cam_pos)
	var e_pos = entity.global_position#get_node("Sprite").get_global_pos()
	var dist = cam_pos.distance_to(e_pos)
	rem.on_screen = dist < 450 # todo - inc to 550
	if rem.on_screen:
		rem.been_on_screen = true
	pass

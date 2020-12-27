extends System

func on_process_entity(entity : Entity, delta: float):
	if entity == null:
		return

	var rem : CheckIfOnScreenComponent = ECS.entity_get_component(entity, "checkifonscreencomponent")
	if rem.been_on_screen:
		if rem.on_screen == false:
			print("Removing " + entity.path)
			ECS.remove_entity(entity)
	pass

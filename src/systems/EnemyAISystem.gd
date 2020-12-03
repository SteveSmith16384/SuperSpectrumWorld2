extends System

func on_process_entity(entity : Entity, delta: float):
	if entity == null:
		return
		
	if ECS.entity_has_component(entity, "checkifonscreencomponent"):
		var rem =  ECS.entity_get_component(entity, "checkifonscreencomponent")
		if rem.on_screen == false:
			return
			
	var hasAI = ECS.entity_get_component(entity, "hasaicomponent")
	var move = ECS.entity_get_component(entity, "movementcomponent")
	
	move.velocity.x = hasAI.move_x * hasAI.move_speed
	move.velocity.y = hasAI.move_y * hasAI.move_speed
	
	if hasAI.move_in_loop:
		hasAI.movement_done = hasAI.movement_done + (abs(move.velocity.x) + abs(move.velocity.y))
		if hasAI.movement_done >= hasAI.move_distance:
			hasAI.movement_done = hasAI.movement_done - hasAI.move_distance
			hasAI.move_x = hasAI.move_x * -1
			hasAI.move_y = hasAI.move_y * -1
	pass

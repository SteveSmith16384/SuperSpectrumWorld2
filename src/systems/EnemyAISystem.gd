extends System

func on_process_entity(entity : Entity, delta: float):
	if entity == null:
		return
		
	var hasAI = ECS.entity_get_component(entity, "hasaicomponent")
	var move = ECS.entity_get_component(entity, "movementcomponent")
	
	if hasAI.move_left:
		move.velocity.x = -hasAI.move_speed
	else:
		move.velocity.x = hasAI.move_speed
	pass

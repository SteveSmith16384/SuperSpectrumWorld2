extends System

func on_process_entity(entity : Entity, delta: float):
	if entity == null:
		return
		
	var hasAI = ECS.entity_get_component(entity.id, "hasaicomponent")
	var move = ECS.entity_get_component(entity.id, "movementcomponent")
	
	if hasAI.move_left:
		move.velocity.x = -10
	pass

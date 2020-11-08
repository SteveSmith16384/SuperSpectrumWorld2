extends System

func on_process_entity(entity : Entity, delta: float):
	pass
	
	
func collision(mover, with):
	if "id" in with:
		if ECS.entity_has_component(mover.id, "isplayercomponent"):
			var player = ECS.entity_get_component(mover.id, "isplayercomponent")
			process_collision(player, with, with)	
		elif ECS.entity_has_component(with.id, "isplayercomponent"):
			var player = ECS.entity_get_component(with.id, "isplayercomponent")
			process_collision(player, mover, with)
	pass


func process_collision(player, other, collision):
	if ECS.entity_has_component(other.id, "harmsplayercomponent"):
		#var c = ECS.entity_get_component(other.id, "harmsplayercomponent")
		if (collision.normal.y < 0):
			ECS.remove_entity(other) # todo
		else:
			print("Player killed")
	
	if ECS.entity_has_component(other.id, "removeoncollisioncomponent"):
		ECS.remove_entity(other)
	
	if ECS.entity_has_component(other.id, "incscoreoncollision"):
		# todo
		pass
	
	

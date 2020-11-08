extends System

func on_process_entity(entity : Entity, delta: float):
	# Do nothing
	pass
	
	
func collision(mover, with, normal):
	if "id" in with:
		if normal == null:
			normal = Vector2(0,0)
		if ECS.entity_has_component(mover.id, "isplayercomponent"):
			var player = ECS.entity_get_component(mover.id, "isplayercomponent")
			process_collision(player, with, normal)	
		elif ECS.entity_has_component(with.id, "isplayercomponent"):
			var player = ECS.entity_get_component(with.id, "isplayercomponent")
			process_collision(player, mover, normal)
	pass


func process_collision(player, other, normal):
	if ECS.entity_has_component(other.id, "harmsplayercomponent"):
		#var c = ECS.entity_get_component(other.id, "harmsplayercomponent")
		if (normal.y < 0):
			ECS.remove_entity(other) # todo
		else:
			print("Player killed")
	
	if ECS.entity_has_component(other.id, "removeoncollisioncomponent"):
		ECS.remove_entity(other)
	
	if ECS.entity_has_component(other.id, "incscoreoncollision"):
		# todo
		pass
	
	

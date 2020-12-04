extends System

func on_process_entity(entity : Entity, delta: float):
	# Do nothing
	pass
	
	
func collision(mover2, with2, normal):
	var mover = mover2
	while mover is Entity == false:
		mover = mover.get_owner()
		if mover == null:
			return
			
	var with = with2
	while with is Entity == false:
		with = with.get_owner()
		if with == null:
			break; # it may be the floor, for when barrels land on floor?
			
		
#	if mover == null:
#		# Must be non-entity entered an area/section
#		return
		
#if "id" in with and "id" in mover: # Are they both entities?
	if normal == null:
		normal = Vector2(0,0)
		
	if with is Entity and ECS.entity_has_component(mover, "isplayercomponent"):
		var player = ECS.entity_get_component(mover, "isplayercomponent")
		process_collision_with_player(mover, with, normal)	
	elif with is Entity and ECS.entity_has_component(with, "isplayercomponent"):
		var player = ECS.entity_get_component(with, "isplayercomponent")
		process_collision_with_player(with, mover, normal)
	else:
		process_collision_with_other(mover, with, normal)


func process_collision_with_player(player : Entity, other : Entity, normal : Vector2):
	if ECS.entity_has_component(other, "harmsplayercomponent"):
		if (normal.y < 0):
			ECS.remove_entity(other)
		else:
			#print("Player killed")
			var main = get_tree().get_root().get_node("Main")
			main.player_killed()
	
	if ECS.entity_has_component(other, "removeoncollisioncomponent"):
		ECS.remove_entity(other)
	
	if ECS.entity_has_component(other, "incscoreoncollision"):
		# todo
		pass

	
func process_collision_with_other(mover : Entity, other, normal : Vector2):
	if ECS.entity_has_component(mover, "removeoncollisioncomponent"):
		ECS.remove_entity(mover)
	if other is Entity and ECS.entity_has_component(other, "removeoncollisioncomponent"):
		ECS.remove_entity(other)
	

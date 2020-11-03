extends System

const GRAVITY = 10.0

func on_process_entity(entity : Entity, delta: float):
	if (entity == null):
		return
		
	var c = ECS.entity_get_component(entity.id, "movementcomponent")

	if c.affected_by_gravity:
		c.velocity.y += GRAVITY

	if (c.affected_by_gravity == false && c.wants_to_move_down == false):
		if c.velocity.y > 0:
			c.velocity.y = 0
			c.can_jump = true
		
	# Move up and down first
	var motion = c.velocity * delta
	if motion.y != 0:
		motion.x = 0
		if entity.has_method("move_and_collide"):
			var res = entity.move_and_collide(motion)
			if (res):
				collision(entity, res)
				c.can_jump = true
				c.velocity.y = 0 # Reset falling speed if we hit something
			else:
				c.can_jump = false
		else:
			entity.position.y += motion.y
		
	# Move left/right
	motion = c.velocity * delta
	if motion.x != 0:
		motion.y = 0
		if entity.has_method("move_and_collide"):
			var res = entity.move_and_collide(motion)
			if (res):
				collision(entity, res)
		else:
			entity.position.x += motion.x
			
	c.velocity.x = 0


func collision(mover, with):
	if "id" in with.collider:
		if ECS.entity_has_component(mover.id, "isplayercomponent"):
			var player = ECS.entity_get_component(mover.id, "isplayercomponent")
			process_collision(player, with.collider, with)	
		elif ECS.entity_has_component(with.collider.id, "isplayercomponent"):
			var player = ECS.entity_get_component(with.collider.id, "isplayercomponent")
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
	
	
	

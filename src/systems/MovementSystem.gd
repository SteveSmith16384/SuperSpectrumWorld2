extends System

const GRAVITY = 10.0

func on_process_entity(entity : Entity, delta: float):
	if (entity == null):
		return
		
	var c = ECS.entity_get_component(entity, "movementcomponent")

	if c.affected_by_gravity:
		c.velocity.y += GRAVITY
		pass
		
#	if c.affected_by_gravity == false && c.wants_to_move_down == false:
#		if c.velocity.y > 0:
#			c.velocity.y = 0
#			c.can_jump = true
		
	# Move up and down first
	var motion = c.velocity * delta
	if motion.y != 0:
		motion.x = 0
		if entity.has_method("move_and_collide"):
			var res = entity.move_and_collide(motion)
			if (res):
				var collider = res.collider
				#var owner = collider.get_owner()
				collision(entity, collider, res.normal)
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
				collision(entity, res.collider, res.normal)
		else:
			entity.position.x += motion.x
			
	c.velocity.x = 0


func collision(e1, e2, normal):
	var coll = ECS.systems.get("collisionsystem")
	coll.collision(e1, e2, normal)
	pass

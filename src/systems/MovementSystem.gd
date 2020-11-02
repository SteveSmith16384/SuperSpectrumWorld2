extends System

const GRAVITY = 10.0

func on_process_entity(entity : Entity, delta: float):
	var c = ECS.entity_get_component(entity.id, "movementcomponent")
	c.velocity.y += GRAVITY

	if (c.affected_by_gravity == false && c.wants_to_move_down == false):
		if c.velocity.y > 0:
			c.velocity.y = 0
			c.can_jump = true
		
	# Move up and down first
	var motion = c.velocity * delta
	if motion.y != 0:
		motion.x = 0
		var res = entity.move_and_collide(motion)
		if (res):
			c.can_jump = true
			c.velocity.y = 0 # Reset falling speed if we hit something
		else:
			c.can_jump = false
		
	# Move left/right
	motion = c.velocity * delta
	if motion.x != 0:
		motion.y = 0
		var collision = entity.move_and_collide(motion)
		#if (collision):
		#	print(collision.collider.to_string())
			
	c.velocity.x = 0

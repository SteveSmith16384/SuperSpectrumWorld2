extends Entity

func _ready():
	var m = get_node("Components/MovementComponent")
	m.affected_by_gravity = false

	var ai = get_node("Components/HasAIComponent")
	ai.move_left = true
	ai.move_speed = 25


func _on_AnimatedSprite_frame_changed():
	var new_offset = $CollisionShape2D.position.x + ($AnimatedSprite.frame * -2)
	$AnimatedSprite.offset.x = new_offset
	pass

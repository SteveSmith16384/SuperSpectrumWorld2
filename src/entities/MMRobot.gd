extends Entity

var seen = false
#var frame_id = 0;

func _ready():
	var m = get_node("Components/MovementComponent")
	m.affected_by_gravity = false

	var ai = get_node("Components/HasAIComponent")
	ai.move_left = true



func _on_AnimatedSprite_frame_changed():
	#frame_id = frame_id + 1
	
	var new_offset = $CollisionShape2D.position.x + ($AnimatedSprite.frame * -2)
	$AnimatedSprite.offset.x = new_offset
	pass # Replace with function body.

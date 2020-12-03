extends Entity

func _ready():


func _on_AnimatedSprite_frame_changed():
	var new_offset = $CollisionShape2D.position.x + ($AnimatedSprite.frame * -2)
	$AnimatedSprite.offset.x = new_offset
	pass

extends Entity

func _on_Ladder_body_entered(body):
	if "id" in body:
		if ECS.entity_has_component(body.id, "movementcomponent"):
			var c = ECS.entity_get_component(body.id, "movementcomponent")
			c.affected_by_gravity = false
			print("On ladder")


func _on_Ladder_body_exited(body):
	if "id" in body:
		if ECS.entity_has_component(body.id, "movementcomponent"):
			var c = ECS.entity_get_component(body.id, "movementcomponent")
			c.affected_by_gravity = true
			print("OFF ladder")

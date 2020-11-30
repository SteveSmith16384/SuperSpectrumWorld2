extends Node2D

func _on_Area2D_body_entered(body):
	var c = ECS.entity_get_component(body, "movementcomponent")
	c.affected_by_gravity = false
	pass


func _on_Area2D_body_exited(body):
	var c = ECS.entity_get_component(body, "movementcomponent")
	c.affected_by_gravity = true
	pass

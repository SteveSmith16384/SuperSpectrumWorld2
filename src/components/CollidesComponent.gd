extends Area2D

signal collided

func _on_CollidesComponent_body_entered(body):
	#emit_signal("collided", body)
	var main = get_tree().get_root().get_node("Main/Systems/CollisionSystem")
	main.collision(body, self.get_owner(), null)
	pass # Replace with function body.

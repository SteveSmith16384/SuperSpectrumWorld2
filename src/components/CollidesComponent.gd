extends Area2D

func _on_CollidesComponent_body_entered(body):
	var main = get_tree().get_root().get_node("Main/Systems/CollisionSystem")
	main.collision(body, self.get_owner(), null)

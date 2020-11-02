extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var player = $Player
	
	$Camera2D.position = player.position
	
	var c = ECS.entity_get_component(player.id, "movementcomponent")

	c.wants_to_move_down = false
	
	if Input.is_action_pressed("ui_left"):
		c.velocity.x = -200
		player.get_node("AnimatedSprite").play("left")
	elif Input.is_action_pressed("ui_right"):
		c.velocity.x = 200
		player.get_node("AnimatedSprite").play("right")
	else:
		player.get_node("AnimatedSprite").stop()
		
	if Input.is_action_pressed("jump"):
		if c.can_jump:
			c.velocity.y += -250
			c.can_jump = false
	elif Input.is_action_pressed("down"):
		c.velocity.y += 20
		c.wants_to_move_down = true
		
	ECS.update()

	pass

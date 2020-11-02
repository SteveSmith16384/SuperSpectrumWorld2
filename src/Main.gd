extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var player = $Player
	var c = ECS.entity_get_component(player.id, "movementcomponent")

	if Input.is_action_pressed("ui_left"):
		c.velocity.x = -200
	elif Input.is_action_pressed("ui_right"):
		c.velocity.x = 200
	if Input.is_action_pressed("jump"):
		if c.can_jump:
			c.velocity.y = -200
			c.can_jump = false
		
	ECS.update()

	pass

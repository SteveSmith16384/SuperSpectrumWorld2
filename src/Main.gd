extends Node2D

const MOMENTUM = true
const ACC = 20
const DEC = .99
const MAX = 200
const MIN = 4

var player
var momentum = Vector2(0, 0)

func _ready():
	player = $Player


func _process(delta):
	$Camera2D.position = player.position
	
	# Player movement
	var c = ECS.entity_get_component(player.id, "movementcomponent")

	c.wants_to_move_down = false
	
	if Input.is_action_pressed("ui_left"):
		if MOMENTUM:
			momentum.x -= ACC
		else:
			c.velocity.x = -200
		player.get_node("AnimatedSprite").play("left")
	elif Input.is_action_pressed("ui_right"):
		if MOMENTUM:
			momentum.x += ACC
		else:
			c.velocity.x = 200
		player.get_node("AnimatedSprite").play("right")
	else:
		if MOMENTUM:
			momentum.x = sign(momentum.x) * DEC
		player.get_node("AnimatedSprite").stop()
	
	if MOMENTUM:
		momentum.x = clamp(momentum.x, -MAX, MAX)
		if momentum.x != 0 && momentum.x <= MIN && momentum.x >= -MIN:
			print("Stopping")
			momentum.x = 0
		c.velocity.x = momentum.x
	
	if Input.is_action_pressed("jump"):
		if c.can_jump:
			c.velocity.y = -250
			c.can_jump = false
	elif Input.is_action_pressed("down"):
		c.velocity.y += 20
		c.wants_to_move_down = true
		
	ECS.update()
	
	#print(c.velocity.y)
	pass


extends Node2D

const MOMENTUM = true
const ACC = 20
const DEC = .99
const MAX = 200
const MIN = 4

var player : Player
var momentum = Vector2(0, 0)

var game_data : GameData

var player_dying = false
var restart_position2 = null


func _ready():

	game_data = preload("GameData.gd").new()

	player = $Player
	$Camera2D.position = player.position
	if restart_position2 == null:
		restart_position2 = player.position


func _process(delta):
	$Camera2D.position = player.position
	
	# Player movement
	var c = ECS.entity_get_component(player, "movementcomponent")

	if player_dying:
		pass
	else:
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
	
	pass


func player_killed():
	player_dying = true
	#$Player.$AnimatedSprite.Visible = false
	$Player.get_node("AnimatedSprite").visible = false
	$RestartTimer.start()


func _on_RestartTimer_timeout():
	$RestartTimer.stop()
	$Player.position = restart_position2
	player_dying = false
	$Player.get_node("AnimatedSprite").visible = true


func inc_score(amt):
	game_data.score += amt
	var hud = get_node("HUD")
	hud.update_score(game_data.score)
	

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
var restart_positions = []
#var restart_idx : int = 0
const max_restart_positions = 2

func _ready():
	game_data = preload("GameData.gd").new()

	player = $Player
	$Camera2D.position = player.position

	for x in range(max_restart_positions):
		restart_positions.push_back(player.position)
	

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
	game_data.lives = game_data.lives - 1
	var hud = get_node("HUD")
	hud.update_lives(game_data.lives)
	player_dying = true
	$Player.get_node("AnimatedSprite").visible = false
	$RestartTimer.stop();
	$RestartTimer.start()
	pass
	

func _on_RestartTimer_timeout():
	if player_dying:
		#$RestartTimer.stop()
		$Player.position = get_restart_pos()
		player_dying = false
		$Player.get_node("AnimatedSprite").visible = true
	else:
		# Store start position
		restart_positions.pop_front()
		restart_positions.push_back(player.position)
	pass


func get_restart_pos():
	return restart_positions[0]
	pass
	
	
func inc_score(amt):
	game_data.score += amt
	var hud = get_node("HUD")
	hud.update_score(game_data.score)
	pass
	

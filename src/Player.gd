extends KinematicBody2D

const GRAVITY = 10.0
var velocity = Vector2()
var can_jump = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("jump") && can_jump:
		velocity.y = -GRAVITY * 50
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += GRAVITY
	
	if velocity.x < 0:
		$AnimatedSprite.animation = "left"
		$AnimatedSprite.play()
	elif velocity.x > 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	# Move up and down first
	var motion = velocity * delta
	motion.x = 0
	var res = move_and_collide(motion)
	if (res):
		can_jump = true
		velocity.y = 0 # Reset falling speed if we hit something
	else:
		can_jump = false
		
	# Move left/right
	motion = velocity * delta
	motion.y = 0
	move_and_collide(motion)

	velocity.x = 0
	#velocity.y = 0
	
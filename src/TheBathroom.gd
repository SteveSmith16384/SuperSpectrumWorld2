extends Node2D


export (NodePath) var patrol_path
var patrol_points
var patrol_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if $Path2D:
		patrol_path = $Path2D
		patrol_points = $Path2D.curve.get_baked_points()
		
	pass # Replace with function body.


func _physics_process(delta):
	var space_rid = get_world_2d().space
	var space_state = Physics2DServer.space_get_direct_state(space_rid)

	if !patrol_path:
		return
	var target = patrol_points[patrol_index]
	var pos = $Saw.position
	var dist = pos.distance_to(target)
	#print(dist)
	if dist < 10:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]
	var velocity = (target - $Saw.position).normalized() * 100
	#$Saw.position += velocity * delta

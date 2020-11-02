extends Entity

var seen = false

func _ready():
	var m = get_node("Components/MovementComponent")
	m.affected_by_gravity = false

	var ai = get_node("Components/HasAIComponent")
	ai.move_left = true

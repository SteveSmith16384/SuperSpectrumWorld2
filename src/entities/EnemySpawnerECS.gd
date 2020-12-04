extends Entity

export var type : int = -1
export var repeat : bool = true
export var qty : int = 1
export var interval : int = 5 # seconds

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Sprite").visible = false
	
	# Copy GUI settings to component
	var sp : SpawnsEnemyComponent = get_node("Components/SpawnsEnemyComponent")
	sp.type = type
	sp.interval = interval
	sp.qty = qty
	#sp.repeat = repeat
	
	pass # Replace with function body.


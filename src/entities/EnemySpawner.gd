extends Node2D


var onscreen = false
export var type : int

func _on_VisibilityNotifier2D_screen_entered():
	onscreen = true
	pass # Replace 


func _on_VisibilityNotifier2D_screen_exited():
	onscreen = false
	pass


func _on_Timer_timeout():
	if onscreen:
		match type:
			Globals.ENEMY_TANK:
				pass
			Globals.ENEMY_EXOLON_ROCKET:
				var scene = load("res://entities/ExolonRocketEntity.tscn")
				var bullet = scene.instance()
				add_child(bullet)
		
	pass

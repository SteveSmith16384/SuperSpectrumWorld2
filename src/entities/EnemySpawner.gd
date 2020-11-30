class_name EnemySpawner
extends Node2D

export var type : int = -1
export var limit : bool = true
export var count : int = 1

var onscreen = false

func _on_VisibilityNotifier2D_screen_entered():
	onscreen = true
	pass # Replace 


func _on_VisibilityNotifier2D_screen_exited():
	onscreen = false
	pass


func _on_Timer_timeout():
	if onscreen:
		if limit:
			if count <= 0:
				return
			count = count - 1

		match type:
			Globals.ENEMY_TANK:
				pass
			Globals.ENEMY_EXOLON_ROCKET:
				var scene = load("res://entities/ExolonRocketEntity.tscn")
				var bullet = scene.instance()
				bullet.position.x = bullet.position.x + 100
				add_child(bullet)
			Globals.ENEMY_AIRWOLF:
				var scene = load("res://entities/AirwolfEnemy.tscn")
				var bullet = scene.instance()
				bullet.position.x = bullet.position.x + 200
				add_child(bullet)
			_:
				Globals.throw_ex("Unhandled enemy: " + str(type))
		
	pass

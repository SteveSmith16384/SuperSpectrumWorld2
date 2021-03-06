class_name EnemySpawner
extends Entity

# This does not use ECS.


export var type : int = -1
export var limit : bool = true
export var count : int = 1

func _ready():
	get_node("Sprite").visible = false
	pass
	

func _on_Timer_timeout():
	#var os = ECS.entity_get_component("checkifonscreencomponent")
	#if os.on_screen:
	if false: #todo
		if limit:
			if count <= 0:
				return
			count = count - 1

		var scene = null
		
		match type:
			Globals.ENEMY_TANK:
				pass
			Globals.ENEMY_EXOLON_ROCKET:
				scene = load("res://entities/ExolonRocketEntity.tscn")
				#var bullet = scene.instance()
				#bullet.position.x = bullet.position.x + 100
				#add_child(bullet)
				
			Globals.ENEMY_AIRWOLF:
				scene = load("res://entities/AirwolfEnemy.tscn")
				#var bullet = scene.instance()
				#bullet.position.x = bullet.position.x + 200
				#add_child(bullet)
				
			Globals.ENEMY_HARRIER_ATTACK_PLANE:
				scene = load("res://entities/HarrierAttackPlane.tscn")
				
			_:
				Globals.throw_ex("Unhandled enemy: " + str(type))

		var bullet = scene.instance()
		add_child(bullet)
		bullet.position.x = bullet.position.x + 100
		
	pass

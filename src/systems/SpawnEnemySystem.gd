class_name SpawnEnemySystem
extends System

func on_process_entity(entity : Entity, delta: float):
	if entity == null:
		return
		
	if ECS.entity_has_component(entity, "checkifonscreencomponent"):
		var rem : CheckIfOnScreenComponent = ECS.entity_get_component(entity, "checkifonscreencomponent")
		if rem.on_screen == false:
			return
	
	
	var sp : SpawnsEnemyComponent = ECS.entity_get_component(entity, "spawnsenemycomponent")
	if sp. sp.qty <= 0:
		return
	
	sp.time_until_next_spawn -= delta
	if sp.time_until_next_spawn <= 0:
		sp.time_until_next_spawn = sp.interval
		spawn_enemy(entity, sp.type)
		sp.qty = sp.qty - 1
	pass
	

func spawn_enemy(parent : Entity, type : int):
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
			
		Globals.ENEMY_BARREL:
			scene = load("res://entities/KongBarrel.tscn")
			
		_:
			Globals.throw_ex("Unhandled enemy: " + str(type))

	var bullet = scene.instance()
	parent.add_child(bullet)
	pass

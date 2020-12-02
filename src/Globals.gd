extends Node

const ENEMY_TANK = 0
const ENEMY_EXOLON_ROCKET = 1
const ENEMY_AIRWOLF = 2
const ENEMY_HARRIER_ATTACK_PLANE = 3

static func throw_ex(msg : String):
	push_error(msg)
	var y = 0
	var x = 10 / y

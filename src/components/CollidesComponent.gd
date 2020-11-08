extends Area2D

signal area_entered

func _ready():
	pass # Replace with function body.


func _on_CollidesComponent_area_entered(area):
	emit_signal("area_entered")
	pass # Replace with function body.

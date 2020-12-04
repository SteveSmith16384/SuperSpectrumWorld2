extends CanvasLayer

func update_score(score : int):
	var node : Label = get_node("GridContainer/Label")
	node.text = "Score: " + str(score)

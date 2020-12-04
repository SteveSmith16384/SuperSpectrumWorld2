extends CanvasLayer

func update_score(score : int):
	var node : Label = get_node("GridContainer/ScoreLabel")
	node.text = "Score: " + str(score)

func update_lives(lives : int):
	var node : Label = get_node("GridContainer/LivesLabel")
	node.text = "Lives: " + str(lives)

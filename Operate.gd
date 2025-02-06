extends Node2D

func _symbol():
	return "+"

func _duplicate():
	var dup = self.duplicate()
	dup.position = Vector2(820, 417)
	self.get_parent().add_child(dup)

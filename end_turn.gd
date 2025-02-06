extends Node2D


func _on_button_pressed():
	print(Global.can_end_turn)
	if Global.can_end_turn:
		Global.can_end_turn = false
		Global.moveable = false
		var enemies = get_tree().get_nodes_in_group('Enim')
		for x in enemies:
			x.action()
			await get_tree().create_timer(1.5).timeout
		Global.moveable = true
		Global.can_end_turn = true
		Global.energy = 3
		Global.turns += 1
		print(Global.turns)

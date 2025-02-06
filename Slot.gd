extends StaticBody2D

func remove_dropable():
	remove_from_group('dropable')

func add_dropable():
	add_to_group('dropable')
	
func add_slot():
	add_to_group('slot')

func remove_slot():
	remove_from_group('slot')

extends StaticBody2D


func remove_dropable():
	remove_from_group('operation_dropable')

func add_dropable():
	add_to_group('operation_dropable')

func add_slot():
	add_to_group('operation_slot')

func remove_slot():
	remove_from_group('operation_slot')

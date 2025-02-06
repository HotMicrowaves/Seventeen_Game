extends Node2D

var is_dragging
var can_draw = false
var Card = preload("res://Card.tscn")
var coords = [Vector2(280, 436), Vector2(396,436), Vector2(507, 436), Vector2(615, 436), Vector2(732, 436)]

# Called every frame. 'delta' is the elapsed time since the previous frame.

func redraw():
	var old = get_tree().get_nodes_in_group('Slotted')
	for x in old.size():
		for y in coords.size():
			if(old[x].get_start_pos() == coords[y]):
				var card_Temp = Card.instantiate()
				card_Temp.position = coords[y]
				$"../Cards".add_child(card_Temp)

func _on_area_2d_mouse_entered():
	can_draw = true


func _on_area_2d_mouse_exited():
	can_draw = false

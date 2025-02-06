extends Node2D

# Called when the node enters the scene tree for the first time.
var answer_ref 
var coords = [Vector2(280, 436), Vector2(396,436), Vector2(507, 436), Vector2(615, 436), Vector2(732, 436)]
var opp_coords = [Vector2(868, 466), Vector2(820, 417), Vector2(821, 466), Vector2(868, 417)]
var Card = preload("res://Card.tscn")
@onready var pop_up = get_tree().get_first_node_in_group("Level_Pop_Up")
var pressed = false

func _ready():
	answer_ref = get_tree().get_nodes_in_group('Answer')

func _on_button_pressed():
	if pressed == false:
		pressed = true
		var level = Global.level
		var equation = ""
		var tween = get_tree().create_tween().set_parallel(true)
		var cards = get_tree().get_nodes_in_group("Slotted")
		var operations = get_tree().get_nodes_in_group("operation_slotted")
		var slots = get_tree().get_nodes_in_group("slot") + get_tree().get_nodes_in_group("operation_slot")
		var target = get_tree().get_first_node_in_group("Target")
		var card_equation = []
		var opp_equation = []
		var movement = cards + operations
		if(cards != null && ((cards.size() - 1 == operations.size() and Global.enemy_target != null) || operations.size() == 0 and cards.size() != 0) and Global.energy != 0):
			Global.moveable = false
			Global.animating = true
			for x in movement:
				tween.tween_property(x, ^"global_position", Vector2(980,575), 1.5)
			await tween.finished
			for x in slots:
				x.remove_slot()
			if(operations.size() != 0):
				print(operations.size())
				for x in 4:
					for y in operations.size():
						if(operations[y].is_in_group("Operation_Slot" + str(x+1))):
							print("Slot " + str(x+1) + ": " + str(operations[y].call_parent()))
				for x in 5:
					for y in cards.size():
						if(cards[y].is_in_group("Slot" + str(x+1))):
							card_equation.append(str(cards[y].get_node("AnimatedSprite2D").animation))
						if(y < operations.size()):
							if(operations[y].is_in_group("Operation_Slot" + str(x+1))):
								opp_equation.append(str(operations[y].call_parent()))
				for x in cards.size():
					equation += card_equation[x]
					if(x < operations.size()):
						equation += opp_equation[x]
			for x in movement:
				x.visible = false
			if(operations.size() != 0):
				await answer_ref[0].attack()
				var expression = Expression.new()
				expression.parse(equation)
				var result = expression.execute()
				if(result == 17):
					var multi = 0
					for x in operations.size():
						var operation = operations[x]
						if operation.call_parent() == "*" or operation.call_parent() == "/":
							multi += 2
						else:
							multi += 1
					result *= multi
					result *= Global.Player_Damage
					result = int(result)
					target.damage(result)
				else:
					target.child.miss()
			else:
				answer_ref[0].discard()
			if(target != null):
				target.remove_from_group('Target')
			Global.enemy_target = null
			await get_tree().create_timer(4).timeout
			redraw()
			for x in operations:
				x.visible = true
				x.position = Vector2(0,0)
				x.remove_from_group("operation_slotted")
				for y in 4:
					x.remove_from_group("Operation_Slot" + str(y+1))
			for x in cards:
				x.queue_free()
			await get_tree().create_timer(1.5).timeout
			answer_ref[0].clone()
			Global.energy -= 1
			Global.moveable = true
			Global.animating = false
		if(get_tree().get_nodes_in_group('Enim').is_empty()):
			if(Global.stage == 17):
				print("hi")
				victory()
			elif(level != Global.level):
				print("hi")
				await get_tree().create_timer(5.0).timeout
				Global.energy = 3
				level_select()
			else:
				print("hi2")
				Global.energy = 3
				level_select()
		pressed = false

func redraw():
	var cards = get_tree().get_nodes_in_group("Slotted")
	var tween = get_tree().create_tween().set_parallel(true)
	for x in cards.size():
		for y in coords.size():
			if(cards[x].get_start_position() == coords[y]):
				var card_Temp = Card.instantiate()
				card_Temp.position = Vector2(970, 436)
				$"../Cards".add_child(card_Temp)
				card_Temp.set_start_position(coords[y])
				tween.tween_property(card_Temp, "global_position", coords[y], 1.5)
				cards[x].queue_free()

func refix():
	var operations = get_tree().get_nodes_in_group("operation_slotted")
	for x in operations.size():
		for y in opp_coords.size():
			if(operations[x].get_start_position() == opp_coords[y]):
				operations[x].position = opp_coords[y]

func level_select():
	await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
	get_tree().change_scene_to_file("res://level_select.tscn")
	Fade.fade_in(1, Color.BLACK, "Diamond", false, false)

func victory():
	print("pass")
	await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
	get_tree().change_scene_to_file("res://victory.tscn")
	Fade.fade_in(1, Color.BLACK, "Diamond", false, false)


func _on_button_mouse_entered():
	Global.over_equals = true


func _on_button_mouse_exited():
	Global.over_equals = false

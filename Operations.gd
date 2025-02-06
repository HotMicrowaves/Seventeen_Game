extends Node2D

@export var the_parent_node: Node2D
var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2
var body_count = 0
var start_pos
var operation_Temp

func _ready():
	start_pos = the_parent_node.get_position()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if draggable and Global.moveable == true:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable == true and body_ref.is_in_group('operation_slot') == false:
				add_to_group("operation_slotted")
				add_to_group(body_ref.get_name())
				body_ref.add_slot()
				tween.tween_property(self,"global_position", body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			else:
				remove_from_group("operation_slotted")
				tween.tween_property(self,"global_position", start_pos,0.2).set_ease(Tween.EASE_OUT)



func _on_area_2d_body_entered(body):
	if body.is_in_group('operation_dropable') && !body.is_in_group('Starting'):
		if body_ref != body && body_ref != null:
			body_ref.add_dropable()
		is_inside_dropable = true
		body_ref = body


func _on_area_2d_body_exited(body):
	var slot_check = false
	if body.is_in_group('operation_dropable'):
		is_inside_dropable = false
		slot_check = true
	if(body_ref != null and slot_check == true):
		if initialPos != start_pos and body_ref.is_in_group('operation_slot') and Global.animating == false:
			print("hi")
			body_ref.remove_slot()
			remove_from_group(body_ref.get_name())
			slot_check = false
	if body.is_in_group('operation_dropable'):
		body_ref = body


func _on_area_2d_mouse_entered():
	if not Global.is_dragging and get_tree().get_nodes_in_group('draggable').size() == 0:
		add_to_group('draggable')
		draggable = true
		scale = Vector2(1.05, 1.05)


func _on_area_2d_mouse_exited():
	if not Global.is_dragging:
		remove_from_group('draggable')
		draggable = false
		scale = Vector2(1, 1)
		
func call_parent():
	return the_parent_node._symbol()

func call_parent_dupe():
	return the_parent_node._duplicate()

func get_start_position():
	return start_pos

extends Node2D

var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2
var body_count = 0
var start_pos
var new_slot
@onready var animate = get_tree().get_first_node_in_group('equals')

func _ready():
	var num  = RandomNumberGenerator.new()
	num.randomize()
	var card_num = num.randi_range(1, 8)
	get_node("AnimatedSprite2D").play(str(card_num))
	start_pos = self.get_position()
	

func _process(_delta):
	if draggable and Global.moveable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable == true and body_ref.is_in_group('slot') == false:
				if body_ref.is_in_group('shield'):
					shield()
					body_ref.add_dropable()
				else:
					add_to_group(body_ref.get_name())
					body_ref.add_slot()
				add_to_group('Slotted')
				tween.tween_property(self,"position", body_ref.position,0.2).set_ease(Tween.EASE_OUT)
				
			else:
				tween.tween_property(self,"global_position", start_pos,0.2).set_ease(Tween.EASE_OUT) 
				remove_from_group('Slotted')


func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group('dropable'):
		if body_ref != body && body_ref != null:
			body_ref.add_dropable()
			new_slot = true
		else:
			new_slot = false
		is_inside_dropable = true
		body_ref = body
 

func _on_area_2d_body_exited(body):
	var slot_check = false
	if body.is_in_group('dropable'):
		is_inside_dropable = false
		slot_check = true
	if(body_ref != null and slot_check == true):
		if(initialPos != start_pos and body_ref.is_in_group('slot') and Global.animating == false):
			remove_from_group(body_ref.get_name())
			body_ref.remove_slot()
			slot_check = false
	if body.is_in_group('dropable'):
		body_ref = body


func _on_area_2d_mouse_entered():
	if not Global.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)


func _on_area_2d_mouse_exited():
	if not Global.is_dragging:
		draggable = false
		scale = Vector2(1, 1)
		
func get_start_position():
	return start_pos

func set_start_position(pos):
	start_pos = pos

func shield():
	Global.moveable = false
	Global.Max_Shield = Global.Player_Shield
	Global.Max_Shield = Global.Max_Shield + int((int(str(self.get_node("AnimatedSprite2D").animation)) * Global.Shield_Modifier))
	Global.Player_Shield = Global.Max_Shield
	get_node("AnimatedSprite2D").play('Transform')
	await get_tree().create_timer(1.4).timeout
	get_node("AnimatedSprite2D").play('Circling')
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(0,0), .75)
	await get_tree().create_timer(.75).timeout
	get_node("AnimatedSprite2D").play("Shield")
	var tween1 = get_tree().create_tween().set_parallel(true)
	tween1.tween_property(self, "scale", Vector2(3, 3), 1)
	tween1.tween_property(self, "modulate:a", 0, 1)
	await get_tree().create_timer(.75).timeout
	animate.redraw()
	Global.moveable = true
	Global.energy = Global.energy - 1

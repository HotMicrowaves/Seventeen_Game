extends Sprite2D

@onready var label = get_node("Label")
@onready var character = get_tree().get_first_node_in_group("Player")
@export var parent_node: Node2D
@onready var right = get_node("Right_Connector")
@onready var left = get_node("Left_Connector")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(parent_node.is_in_group('Left_Node')):
		label.text = (str(Global.stage-1))
		if(Global.stage == 1):
			parent_node.visible = false
		else:
			parent_node.visible = true
	elif(parent_node.is_in_group('Right_Node')):
		label.text = (str(Global.stage+1))
		if(Global.stage == 17):
			parent_node.visible = false
		else:
			parent_node.visible = true
	elif(parent_node.is_in_group('Center_Node')):
		label.text = (str(Global.stage))
		if(Global.stage == 1):
			left.visible = false
		else:
			left.visible = true
		if(Global.stage == 17):
			right.visible = false
		else:
			right.visible = true



func _on_button_pressed():
	if(parent_node.is_in_group('Right_Node') and character.position != parent_node.position):
		character.anim.play("Walk")
		var tween = get_tree().create_tween()
		tween.tween_property(character, "position", parent_node.position, 1)
		await tween.finished
		await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
		Global.stage += 1
		get_tree().change_scene_to_file("res://Arena.tscn")
		Fade.fade_in(1, Color.BLACK, "Diamond", false, false)

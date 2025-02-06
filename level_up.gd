extends Node2D

@onready var Previous = get_node("Sprite2D/Previous_Level")
@onready var Current = get_node("Sprite2D/Current_Level")
@onready var Changes = get_node("Changes")
# Called when the node enters the scene tree for the first time.

func leveled_up():
	self.visible = true
	Previous.text = str(Global.level - 1)
	Current.text = str(Global.level)
	Changes.text = "Level Up! (" + str(Global.level - 1) + " --> " + str(Global.level) + ")\n" + "+5 Max Hp (" + str(Global.Max_HP) + "/" + str(Global.Max_HP) + " Total)\n" + "+1.1x Attack (" + str(Global.Player_Damage) + "x Total)\n" + "+1.3x Shield (" + str(Global.Shield_Modifier) + "x Total)"
	


func _on_okay_pressed():
	self.visible = false

extends Node2D

var Max_HP = 50
var HP = 50
var Attack = 2
var Shield = 0
var Heal = 20
var XP = 8
@onready var child = get_node("Enemy")
# Called when the node enters the scene tree for the first time.

func action():
	child.action()
	
func damage(taken):
	child.damage(taken)

extends Node2D

var Max_HP = 65
var HP = 65
var Attack = 4
var Shield = 15
var Heal = 0
var XP = 7
@onready var child = get_node("Enemy")


func action():
	child.action()

func damage(taken):
	child.damage(taken)

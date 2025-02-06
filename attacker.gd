extends Node2D

var Max_HP = 55
var HP = 55
var Attack = 10
var Shield = 0
var Heal = 0
var XP = 10
@onready var child = get_node("Enemy")


func action():
	child.action()

func damage(taken):
	child.damage(taken)

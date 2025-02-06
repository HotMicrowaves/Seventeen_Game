extends Node2D

@onready var anim = get_node("AnimatedSprite2D") 
@onready var pop_up = get_tree().get_first_node_in_group("Level_Pop_Up")
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Idle")
	Global.Max_HP = 50 + (5 * (Global.level - 1))
	Global.Player_HP = Global.Max_HP
	Global.Player_Damage = 1 + (0.1 * (Global.level - 1))
	Global.Shield_Modifier = 1 + (0.3 * (Global.level - 1))

func walk():
	anim.play("Walk")

func xp(value):
	Global.XP += value
	if(Global.XP >= Global.level * 25):
		Global.XP = 0
		value -= Global.level * 25
		xp(value)
		Global.level += 1
		level_up()
		

func level_up():
	Global.Max_HP += 5
	Global.Player_HP = Global.Max_HP
	Global.Player_Damage += 0.1
	Global.Shield_Modifier += 0.3
	pop_up.leveled_up()
	

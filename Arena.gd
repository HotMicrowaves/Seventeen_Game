extends Node2D

var Attacker = preload("res://attacker.tscn")
var Defender = preload("res://defender.tscn")
var Healer = preload("res://healer.tscn")
var Enemies = [Attacker, Defender, Healer]
var Enemy_Coords = [Vector2(770, 336), Vector2(850, 336), Vector2(930, 336)]

func _on_tree_entered():
	if(Global.stage != 1 or Global.skip_tutorial == true):
		Global.moveable = true
		Global.can_end_turn = true
		var num  = RandomNumberGenerator.new()
		num.randomize()
		var enemy_num = num.randi_range(0, 2)
		if Global.stage >= 10:
			enemy_num = 2
		make_Enemies(enemy_num)
	else:
		var Enemy_Temp = Enemies[0].instantiate()
		Enemy_Temp.global_position = Enemy_Coords[1]
		$Enemies.add_child(Enemy_Temp)

func make_Enemies(x):
	if(x >= 0):
		var num  = RandomNumberGenerator.new()
		num.randomize()
		var enemy = num.randi_range(0, 2)
		var Enemy_Temp = Enemies[enemy].instantiate()
		Enemy_Temp.global_position = Enemy_Coords[x]
		$Enemies.add_child(Enemy_Temp)
		make_Enemies(x-1)

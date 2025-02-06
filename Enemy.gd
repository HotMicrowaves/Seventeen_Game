extends Node2D

@export var the_parent_node: Node2D
@onready var HP_Bar = get_node("Enemy_HP")
@onready var Shield_Bar = get_node("Enemy_Shield")
@onready var animation = get_node("AnimatedSprite2D")
@onready var label = get_node("Label")
@onready var Player_HP = get_tree().get_nodes_in_group("HP_Bar")
@onready var Player_Shield = get_tree().get_nodes_in_group("Shield_Bar")
@onready var Player = get_tree().get_first_node_in_group("Player")
var current_Shield = 0
var max_Shield = 100
var max_HP
var current_HP
var animating = false
var heal_targets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	max_HP = int(the_parent_node.HP + ((Global.stage - 1) * 5))
	current_HP = max_HP
	HP_Bar.max_value = max_HP
	HP_Bar.value = current_HP
	Shield_Bar.max_value = max_Shield
	Shield_Bar.value = current_Shield
	animation.play("Idle")
	the_parent_node.add_to_group('Enim')

func _on_button_focus_entered():
	if Global.can_target:
		Global.enemy_target = the_parent_node.get_position()
		the_parent_node.add_to_group('Target')
		HP_Bar.visible = true
		Shield_Bar.visible = true


func _on_button_focus_exited():
	if(Global.over_equals == false):
		the_parent_node.remove_from_group('Target')
	HP_Bar.visible = false
	Shield_Bar.visible = false

func _on_animated_sprite_2d_animation_finished():
	var num  = RandomNumberGenerator.new()
	num.randomize()
	var delay = num.randf_range(0, 2.5)
	await get_tree().create_timer(delay).timeout
	if(not animation.is_playing()):
		animation.play("Idle")

func action():
	randomize()
	var option = 0
	if(the_parent_node.Heal == 0 && the_parent_node.Shield != 0):
		var choice = [1, 1, 2, 2, 2]
		option = choice.pick_random()
	elif(the_parent_node.Shield == 0 && the_parent_node.Heal != 0):
		var choice = [1, 0, 0, 0]
		option = choice.pick_random()
	else:
		option = 1
	if(option == 1):
		attack()
	elif(option == 2):
		shield()
	else:
		var targets = get_tree().get_nodes_in_group('Enim')
		for x in targets.size():
			if targets[x].child.max_HP > targets[x].child.current_HP:
				heal_targets.append(targets[x])
		if heal_targets.is_empty():
			attack()
		else:
			heal()

func attack():
	var dmg = int(the_parent_node.Attack  * ( 1 + ((Global.stage - 1) * 0.3)))
	if(dmg > Global.Player_Shield):
		dmg -= Global.Player_Shield
		Global.Player_Shield = 0
		Global.Player_HP -= dmg
	else:
		Global.Player_Shield -= dmg
	if(Global.Player_HP < 0):
		Utils.newGame()
		await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
		get_tree().change_scene_to_file("res://game_over.tscn")
		Fade.fade_in(1, Color.BLACK, "Diamond", false, false)
	animation.play("Attack")
	await animation.animation_finished
	Player.anim.play("Hurt")
	await animation.animation_finished
	Player.anim.play("Idle")
	
	

func shield():
	if(max_Shield == 100):
		max_Shield = int(the_parent_node.Shield * ( 1 + ((Global.stage - 1) * 0.2)))
	else:
		max_Shield += int(the_parent_node.Shield * ( 1 + ((Global.stage - 1) * 0.2)))
	current_Shield += int(the_parent_node.Shield * ( 1 + ((Global.stage - 1) * 0.2)))
	Shield_Bar.max_value = max_Shield
	Shield_Bar.value = current_Shield
	animation.play("Shield")

func heal():
	animation.play("Heal")
	for x in heal_targets.size():
		var current_target = heal_targets[x]
		var tween = get_tree().create_tween().set_parallel(true)
		current_target.child.current_HP += int(the_parent_node.Heal * ( 1 + ((Global.stage - 1) * 0.3)))
		if(current_target.child.current_HP > current_target.Max_HP):
			current_target.child.current_HP = current_target.Max_HP
		current_target.child.HP_Bar.visible = true
		tween.tween_property(current_target.child.HP_Bar, "value", current_target.child.current_HP, 1)
		await get_tree().create_timer(1.0).timeout
		current_target.child.HP_Bar.visible = false
	for x in heal_targets.size():
		heal_targets.erase(heal_targets[0])

func damage(taken):
	HP_Bar.visible = true
	Shield_Bar.visible = true
	if(taken > current_Shield):
		taken -= current_Shield
		current_Shield = 0
		current_HP -= taken
	else:
		current_Shield -= taken
	await get_tree().create_timer(.75).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(Shield_Bar, "value", current_Shield, 1)
	tween.tween_property(HP_Bar, "value", current_HP, 1)
	await get_tree().create_timer(3.0).timeout
	if(current_HP <= 0):
		if Global.in_tutorial == true:
			current_HP = 1
		else:
			animation.play("Death")
			await animation.animation_finished
			self.queue_free()
			Player.xp(the_parent_node.XP * Global.stage)
			the_parent_node.remove_from_group('Enim')
	else:
		HP_Bar.visible = false
		Shield_Bar.visible = false

func miss():
	await get_tree().create_timer(1.5).timeout
	label.visible = true
	label.set_modulate(Color(0, 0, 0, 0))
	var tween = get_tree().create_tween()
	tween.tween_property(label, "modulate:a", 1, .5)
	tween.tween_property(label, "modulate:a", 0, .5).set_delay(.5)

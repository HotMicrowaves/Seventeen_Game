extends RichTextLabel

var x = 0
var tutorial_text = []
var arrows = []
var animate = true
@onready var Enemy = get_tree().get_first_node_in_group('Enim')
var pressing = false
var speed = .75

# Called when the node enters the scene tree for the first time.
func _ready():
	print(Global.skip_tutorial)
	if Global.stage != 1 or Global.skip_tutorial == true:
		self.visible = false
		Global.can_end_turn = true
		Global.can_target = true
	else:
		Global.in_tutorial = true
	tutorial_text.append("Welcome to 17!")
	tutorial_text.append("The goal of this game is to beat all of the monsters! But how might you do that?")
	tutorial_text.append("Using these nifty cards and operations you see below, we're able to make numbers!")
	tutorial_text.append("Why you ask?! Well to beat the enemies! Each time you make the number 17, you can hurt those pesky enemies!")
	tutorial_text.append("Come on, try it! Put the cards below and operations to make a math equation that will get 17! When you finish, click the enemy you want to attack, and press the equals sign!")
	tutorial_text.append("Nice job! Every time you get the number 17, your damage will increase for the number of operations you use!")
	tutorial_text.append("But wait, there's more! If you use the multiplcation and division sign, you'll do even more damage! If you're in a tight spot, make sure to look to use those operations!")
	tutorial_text.append("However! Dividng a number that doesn't give a whole number will cause the equation to fail! Be careful!")
	tutorial_text.append("Lets look at our own stats.")
	tutorial_text.append("You have your energy, which is how many actions you are able to do per turn.")
	tutorial_text.append("Your health, which determines how much damage you can take before you die.")
	tutorial_text.append("And you have your shield! Which you can use to gain extra, temporary life.")
	tutorial_text.append("In 17, you have 3 actions: Attack, Discard, and Block.")
	tutorial_text.append("Since we've already went over Attack, lets look at discard.")
	tutorial_text.append("If you don't have the cards you need to make 17, you're able to discard any number of cards you want by putting them down below without operations! Try it out! Press the equals sign when you're ready to discard!")
	tutorial_text.append("Now we're able to use our new cards to try and make 17! However, there's one more thing we can do.")
	tutorial_text.append("If you put one of your cards on top of that shield card, you can gain shield equal to the cards number! Try it!")
	tutorial_text.append("Uh oh, we're out of energy!")
	tutorial_text.append("When you run out of energy, you won't be able to make any more actions, so you press the end turn button, and the enemies get to go!")
	tutorial_text.append("This little guy here is an attacker, he can only attack you. Later, you'll find more types of enemies that can block and heal!")
	tutorial_text.append("Beceause the enemy attacked, you can see you lost HP and Shield at the bottom!")
	tutorial_text.append("Now that you've learned everything, go beat those enemies!")
	self.text = tutorial_text[x]
	x += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(self.visible_ratio <= 1.0):
		self.visible_ratio += delta * speed

func _on_button_pressed():
	if not pressing:
		pressing = true
		Global.moveable = false
		Global.can_end_turn = false
		if(x == 5):
			if Enemy.child.current_HP == Enemy.child.max_HP:
				x -= 1
				animate = false
				if Global.energy != 3:
					Global.energy = 3
			else:
				animate = true
		if(x == 15):
			if Global.energy != 1:
				x -= 1
				animate = false
				Global.energy = 2
			else:
				animate = true
		if(x == 17):
			if Global.Player_Shield == 0:
				x -= 1
				animate = false
				if Global.energy != 1:
					Global.energy = 1
			else:
				animate = true
		if(not arrows.is_empty() and animate == true):
			for y in arrows.size():
				arrows[y].animation.play("Dissolve")
			await get_tree().create_timer(1.33).timeout
		if(not get_tree().get_nodes_in_group("Tut_" + str(x)).is_empty()):
			arrows = get_tree().get_nodes_in_group("Tut_" + str(x))
			for y in arrows.size():
				var arrow = arrows[y]
				arrow.visible = true
				arrow.animation.play("Idle")
		else:
			arrows = []
		if(x == 4):
			Global.moveable = true
			Global.can_target = true
		if(x == 14 or x == 16):
			Global.moveable = true
		if(x == 18):
			Global.can_end_turn = true
		if(x == tutorial_text.size()):
			self.visible = false
			Global.in_tutorial = false
			Global.moveable = true
			Global.can_end_turn = true
			Global.can_target = true
		else:
			self.text = tutorial_text[x]
			self.visible_ratio = 0
		x += 1
		pressing = false

func complete():
	if(x == 4 or x == 14 or x == 16 or x == 18):
		_on_button_pressed()

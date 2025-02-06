extends Button

var x = 0
var choices = ["Yes", "No"] 
# Called when the node enters the scene tree for the first time.


func _on_pressed():
	self.text = str(choices[x%2])
	Global.skip_tutorial = (x % 2 == 0)
	print(Global.skip_tutorial)
	x += 1



func _on_settings_tree_entered():
	if Global.skip_tutorial == true:
		self.text = "Yes"
	else:
		self.text = "No"

extends Label


func _process(_delta):
	if(Global.Max_Shield == 0):
		self.text = ""
	else:
		self.text = str(Global.Player_Shield) + "/" + str(Global.Max_Shield)

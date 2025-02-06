extends Label

func _process(_delta):
	self.text = str(Global.Player_HP) + "/" + str(Global.Max_HP)

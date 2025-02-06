extends TextureProgressBar




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(Global.Max_Shield == 0):
		self.max_value = 100
	else:
		self.max_value = Global.Max_Shield
	self.value = Global.Player_Shield

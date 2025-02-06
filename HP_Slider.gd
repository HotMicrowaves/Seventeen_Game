extends TextureProgressBar

func _ready():
	self.max_value = Global.Max_HP
	self.value = Global.Player_HP

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.max_value = Global.Max_HP
	self.value = Global.Player_HP 

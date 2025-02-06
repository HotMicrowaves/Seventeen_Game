extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = "You reached: Stage " + str(Global.stage)

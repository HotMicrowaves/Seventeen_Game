extends HSlider

var master_bus = AudioServer.get_bus_index("Master")

func _ready():
	AudioServer.set_bus_volume_db(master_bus, Global.Volume)

func _on_value_changed(value):
	Global.Volume = value
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -20:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)


func _on_settings_tree_entered():
	self.value = Global.Volume
	if value == -20:
		AudioServer.set_bus_mute(master_bus, true)

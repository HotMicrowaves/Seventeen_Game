extends Node2D

var master_bus = AudioServer.get_bus_index("Master")

func _on_level_select_pressed():
	await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
	get_tree().change_scene_to_file("res://level_select.tscn")
	Fade.fade_in(1, Color.BLACK, "Diamond", false, false)


func _on_quit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	Global.last = 0
	await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
	get_tree().change_scene_to_file("res://settings.tscn")
	Fade.fade_in(1, Color.BLACK, "Diamond", false, false)


func _on_load_game_pressed():
	Utils.loadGame()
	if Global.XP != 0 or Global.stage != 1:
		Fade.fade_in(1, Color.BLACK, "Diamond", false, false)
		await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
		get_tree().change_scene_to_file("res://level_select.tscn")
		Fade.fade_in(1, Color.BLACK, "Diamond", false, false)


func _on_new_game_pressed():
	Utils.newGame()
	Utils.loadGame()
	get_tree().change_scene_to_file("res://Arena.tscn")


func _on_tree_entered():
	if Global.first_enter == true: 
		Utils.loadGame()
	AudioServer.set_bus_volume_db(master_bus, Global.Volume)


func _on_tree_exited():
	Global.first_enter = false

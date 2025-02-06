extends Node2D



func _on_quit_pressed():
	Utils.newGame()
	await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
	get_tree().quit()


func _on_play_pressed():
	await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
	get_tree().change_scene_to_file("res://Arena.tscn")
	Fade.fade_in(1, Color.BLACK, "Diamond", false, false)

extends Node2D


func _on_back_pressed():
	if(Global.last == 1):
		await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
		get_tree().change_scene_to_file("res://level_select.tscn")
		Fade.fade_in(1, Color.BLACK, "Diamond", false, false)
	else:
		await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
		get_tree().change_scene_to_file("res://main.tscn")
		Fade.fade_in(1, Color.BLACK, "Diamond", false, false)

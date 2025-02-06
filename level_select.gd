extends Node2D

@onready var Save = get_node("Save")

func _on_quit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	Global.last = 1
	await Fade.fade_out(1, Color.BLACK, "Diamond", false, false).finished
	get_tree().change_scene_to_file("res://settings.tscn")
	Fade.fade_in(1, Color.BLACK, "Diamond", false, false)


func _on_save_pressed():
	Utils.saveGame()

extends Node

const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"Player_HP": Global.Player_HP,
		"Max_HP": Global.Max_HP,
		"Stage": Global.stage,
		"Level": Global.level,
		"XP": Global.XP,
		"Skip_Tutorial": Global.skip_tutorial,
		"Volume": Global.Volume,
		"Turns": Global.turns,
		"Shield": Global.Player_Shield
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)


func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Global.Player_HP = current_line["Player_HP"]
				Global.Max_HP = current_line["Max_HP"]
				Global.stage = current_line["Stage"]
				Global.level = current_line["Level"]
				Global.XP = current_line["XP"]
				Global.skip_tutorial = current_line["Skip_Tutorial"]
				Global.Volume = current_line["Volume"]
				Global.turns = current_line["Turns"]
				Global.Player_Shield = current_line["Shield"]

func newGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"Player_HP": 50,
		"Max_HP": 50,
		"Stage": 1,
		"Level": 1,
		"XP": 0,
		"Skip_Tutorial": Global.skip_tutorial,
		"Volume": Global.Volume,
		"Turns": 1,
		"Shield": 0
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)

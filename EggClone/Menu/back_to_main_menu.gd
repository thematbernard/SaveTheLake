extends Control

const MAIN_GAME = preload("res://Scenes/main_game.tscn")
const main_menu = preload("res://Menu/main_menu.tscn")

func _on_to_main_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(MAIN_GAME)
	#get_tree().change_scene_to_packed(main_menu)

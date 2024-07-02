class_name GameOver
extends Control

@onready var main_menu = preload("res://Menu/main_menu.tscn")
@onready var quit = $Quit
@onready var main_menu_button = $"Main Menu"
const MAIN_GAME = preload("res://Scenes/main_game.tscn")

signal reset_game_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connect_to_signals()


func on_main_menu_pressed(): 
	get_tree().change_scene_to_packed(MAIN_GAME)

func on_quit_pressed():
	print("quit pressed")
	get_tree().quit()
	

func handle_connect_to_signals():
	quit.button_down.connect(on_quit_pressed)
	main_menu_button.button_down.connect(on_main_menu_pressed)

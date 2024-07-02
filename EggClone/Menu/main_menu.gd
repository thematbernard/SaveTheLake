class_name MainMenu
extends Control

@onready var play_button = $MarginContainer/HBoxContainer/VBoxContainer/PlayButton as Button
@onready var controls_button = $MarginContainer/HBoxContainer/VBoxContainer/ControlsButton as Button
@onready var options_button = $MarginContainer/HBoxContainer/VBoxContainer/OptionsButton as Button
@onready var quit_button = $MarginContainer/HBoxContainer/VBoxContainer/QuitButton as Button
@onready var options_menu = $OptionsMenu as OptionsMenu
@onready var control_menu = $ControlMenu as ControlMenu
@onready var margin_container = $MarginContainer as MarginContainer
@onready var start_level = preload("res://Scenes/main_game.tscn")
@onready var parallax_background = $ParallaxBackground

var scroll_speed = Vector2(50, 0)

func _ready():
	get_tree().paused = false
	handle_connect_to_signals()

func _process(delta):
	#print("making it to this process line")
	get_tree().paused = false
	parallax_background.scroll_offset += scroll_speed * delta

func on_play_pressed():
	#print("getting input")
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed():
	get_tree().quit()
	
func on_options_pressed():
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func on_controls_pressed():
	margin_container.visible = false
	control_menu.set_process(true)
	control_menu.visible = true

func on_exit_options_menu():
	margin_container.visible = true
	options_menu.visible = false

func on_exit_controls_menu():
	margin_container.visible = true
	control_menu.visible = false

func handle_connect_to_signals():
	play_button.button_down.connect(on_play_pressed)
	options_button.button_down.connect(on_options_pressed)
	controls_button.button_down.connect(on_controls_pressed)
	quit_button.button_down.connect(on_exit_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	control_menu.exit_controls_menu.connect(on_exit_controls_menu)

extends CharacterBody2D

@export var speed = 500.0
@export var jump_height = 500.0
@export var gravity = 1000.0
@onready var foot_steps = $FootSteps

var view_port = Vector2.ZERO
var player_direction = Vector2.ZERO

var bullet_scene = preload("res://Scenes/egg_bullet.tscn")
var bullet_speed = 50
var shooting = false

func _ready():
	# Initialize the viewport size
	view_port = get_viewport_rect().size
	$Sprite2D/PlayerAnimation.play("run")

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		direction.x -= 1
		$Sprite2D.flip_h = false
	if Input.is_action_pressed("right"):
		direction.x += 1
		$Sprite2D.flip_h = true
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		player_direction.y = -jump_height
	if Input.is_action_pressed("shoot") and shooting == false:
		shoot()
	
	if direction.length() > 0 and is_on_floor():
		if not foot_steps.playing:
			foot_steps.play()
	else:
		if foot_steps.playing:
			foot_steps.stop()
	
	if direction.x != 0:
		direction = direction.normalized()
	
	player_direction.x = direction.x * speed
	
	# Apply gravity
	player_direction.y += gravity * delta
	
	velocity = player_direction
	move_and_slide()
	
	# Clamp the player's position within the viewport boundaries after move_and_slide
	var my_position = global_position
	
	if my_position.x < 0:
		my_position.x = 0
	elif my_position.x > view_port.x:
		my_position.x = view_port.x
	
	global_position = my_position
	
func shoot():
	$Sprite2D/PlayerAnimation.play("shoot")
	shooting = true
	$ShootTimer.start()
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Marker2D.global_position
	get_parent().connect_bullet_signal(bullet)
	start_run()
	
func start_run():
	$Sprite2D/PlayerAnimation.queue("run")


func _on_shoot_timer_timeout():
	shooting = false

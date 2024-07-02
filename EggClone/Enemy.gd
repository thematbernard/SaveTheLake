extends Path2D

@onready var path_follow : PathFollow2D = $PathFollow2D
@export var speed = .1
@onready var sprite : Sprite2D = $Sprite2D
const SCORE = preload("res://Scenes/score.tscn")

var bullet_scene = preload("res://Scenes/enemy_bullet.tscn")
var forward = true
var rng = RandomNumberGenerator.new()
var guessed_number = false
var already_guessed = false
var current_shots = 0

func _ready():
	$BulletTimer.start()
	$PathFollow2D/Sprite2D/AnimationPlayer.play("run")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if forward:
		generate_number_guess()
		#print("Path_follow.progress_ratio" + str(path_follow.progress_ratio))
		check_sprite_forward()
		if path_follow.progress_ratio >= .99:
			path_follow.progress_ratio = path_follow.progress_ratio
			#when forward timer timesout we set forward to be false if true or true if false
			$ForwardTimer.start()
		if guessed_number == false:
			path_follow.progress_ratio += speed * delta 
	else:
		generate_number_guess()
		check_sprite_backward()
		if guessed_number == false:
			#print("backward" + str(path_follow.progress_ratio))
			path_follow.progress_ratio -= speed * delta 
			if path_follow.progress_ratio <= 0.005:
				path_follow.progress_ratio = .005
				#when forward timer timesout we set forward to be false if true or true if false
				$ForwardTimer.start()

func check_sprite_forward():
	if path_follow.progress_ratio <= .25:
		$PathFollow2D/Sprite2D.flip_h = true
	if path_follow.progress_ratio >= .26 and path_follow.progress_ratio <= .75:
		$PathFollow2D/Sprite2D.flip_h = false
	if path_follow.progress_ratio >= .76 and path_follow.progress_ratio <= 1:
		$PathFollow2D/Sprite2D.flip_h = true

func check_sprite_backward():
	if path_follow.progress_ratio >= .76:
		$PathFollow2D/Sprite2D.flip_h = false
	if path_follow.progress_ratio <= .75 and path_follow.progress_ratio >= .26:
		$PathFollow2D/Sprite2D.flip_h = true
	if path_follow.progress_ratio <= .25 and path_follow.progress_ratio >= 0:
		$PathFollow2D/Sprite2D.flip_h = false


func generate_number_guess():
	var random_number = rng.randi_range(0, 20)
	if already_guessed == false:
		if random_number == 2:
			already_guessed = true
			guess_cooldown()
			guessed_number = true
			#when timer times out we make guessed_number false
			$GuessTimer.start()
		
func guess_cooldown():
	#on timeout we make already_guessed = false
	$AlreadyGuessedTimer.start()


func _on_bullet_timer_timeout():
	current_shots += 1
	drop_bullet()

func check_shots():
	if current_shots % 10 == 0:
		$BulletTimer.wait_time -= .1

func drop_bullet():
	var bullet = bullet_scene.instantiate()
	var bullet_rng = rng.randf_range(1, 10)
	var new_bullet_size = bullet_rng / 3
	bullet.scale = Vector2(new_bullet_size, new_bullet_size)
	get_parent().add_child(bullet)
	bullet.position = $PathFollow2D/Marker2D.global_position
	check_shots()
	$BulletTimer.start()


func _on_forward_timer_timeout():
	if forward == true:
		forward = false
	if forward == false:
		forward = true

func _on_guess_timer_timeout():
	guessed_number = false

func _on_already_guessed_timer_timeout():
	already_guessed = false

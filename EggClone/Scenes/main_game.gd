extends Node2D

@onready var lives : Sprite2D = $Lives
@onready var bullet_collector : Node2D = $EnemyBulletCollector
@onready var parallax_background = $ParallaxBackground
@onready var game_over = $Game_Over
@onready var back_to_main_menu = $BackToMainMenu




var current_score = 0
var HitPoints = 3

var scroll_speed = Vector2(50, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	reset_game()
	#reset score lable
	$Score/Label.text = "Score: " + str(current_score)
	if bullet_collector:
		var bullet_area = bullet_collector.get_node("EnemyBulletCollectorArea")
		bullet_area.connect("lose_life", Callable(self, "_on_lose_life"))
		bullet_area.connect("enemy_bullet_detected", Callable(self, "_on_enemy_bullet_detected"))
	else:
		print("Bullet Collector not found")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	parallax_background.scroll_offset += scroll_speed * delta

func _on_bullet_score_point():
	current_score += 1
	$Score/Label.text = "Score: " + str(current_score)

func connect_bullet_signal(bullet):
	bullet.connect("score_point", Callable(self, "_on_bullet_score_point"))
	
func reset_game():
	get_tree().paused = false
	current_score = 0
	HitPoints = 3
	$Score/Label.text = "Score: " + str(current_score)
	lives.frame_coords.x = 0
	for i in range(lives.get_child_count()):
		var life_sprite = lives.get_child(i)
		life_sprite.frame_coords.x = 0

func handle_game_over():
	get_tree().paused = true
	game_over.visible = true

func _on_lose_life():
	#print("made it to lose life")
	if HitPoints > 0:
		var last_life_sprite = lives.get_child(HitPoints - 2)
		last_life_sprite.frame_coords.x = 1
		HitPoints -= 1
		#print("Lost a life!")
	if HitPoints == 0:
		lives.frame_coords.x = 1
		print("game over")
		handle_game_over()

func _on_enemy_bullet_collector_area_enemy_bullet_detected():
	print("enemy bullet detected!")

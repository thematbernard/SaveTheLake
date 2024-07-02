extends Area2D

signal enemy_bullet_detected(body)
signal lose_life

@onready var bubble_sound : AudioStreamPlayer2D = $BubblePlayer
@onready var enemy_bullet_collector : Area2D = $EnemyBulletCollectorArea
var vial

func _ready():
	if enemy_bullet_collector:
		#enemy_bullet_collector.connect("enemy_bullet_detected", Callable(self, "_on_enemy_bullet_detected"))
		enemy_bullet_collector.connect("lose_life", Callable(self, "_on_lose_life"))

func _on_body_entered(body):
	if body.is_in_group("bullet"):
		emit_signal("enemy_bullet_detected", body)
		lose_life.emit()
		handle_sound(body)
		#body.queue_free()

func handle_sound(body):
	vial = body
	bubble_sound.play()
	bubble_sound.connect("finished", Callable(self, "_on_bubble_sound_finished"))

func _on_bubble_sound_finished(body):
	print("deleting")
	vial.queue_free()

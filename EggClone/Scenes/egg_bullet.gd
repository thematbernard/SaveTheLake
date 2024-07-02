extends CharacterBody2D

signal score_point

var speed = 300
var rotation_speed = 1.0
@onready var sprite: Sprite2D = $Sprite2D
@onready var break_sound : AudioStreamPlayer2D = $Break

func _physics_process(delta):
	velocity.y = -1
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
	update_rotation(delta * 10)
	


func update_rotation(delta):
	if velocity.length() > 0:
		var angle = velocity.angle()
		sprite.rotation += rotation_speed * delta



func _on_area_2d_body_entered(body):
	if body.is_in_group("bullet"):
		break_sound.play()
		body.queue_free()
		score_point.emit()
		$Sprite2D.visible = false
		#free the egg aswell
		break_sound.connect("finished", Callable(self, "_on_break_sound_finished"))
		
func _on_break_sound_finished():
	queue_free()

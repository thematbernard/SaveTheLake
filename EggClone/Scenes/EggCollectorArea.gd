extends Area2D

signal egg_detected(body)


func _on_body_entered(body):
	if body.name == "EggBullet":
		emit_signal("egg_detected")
		print("detected egg_bullet, deleting")
		body.queue_free()

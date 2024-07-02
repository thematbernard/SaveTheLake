extends CharacterBody2D

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

var speed = 150
var size = 1.0
var size_vector = Vector2.ZERO
var rotation_speed = 1.0

func _ready():
	randomize_sprites()

func _physics_process(delta):
	velocity.y = .5
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
	#print(self.position)
	update_rotation(delta * 1)

func randomize_sprites():
	var rand_index = randi() % 3
	sprite.frame = rand_index

func update_rotation(delta):
	if velocity.length() > 0:
		var angle = velocity.angle()
		sprite.rotation -= rotation_speed * delta

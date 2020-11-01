extends KinematicBody2D

export var speed = 1
export var damage = 100
export var max_constraint = 100
export var min_constraint = -100
var direction = 1
var velocity = Vector2.ZERO

func _physics_process(_delta):
	if direction < 0 and !$Sprite.flip_h:
		$Sprite.flip_h = true
	if direction > 0 and $Sprite.flip_h:
		$Sprite.flip_h = false
	velocity.x += direction * speed
	move_and_slide(velocity, Vector2.UP)
	if direction > 0 and position.x >= max_constraint:
		velocity.x = 0
		direction = -1
	if direction < 0 and position.x <= min_constraint:
		velocity.x = 0
		direction = 1

	
	


func _on_Area2D_body_entered(body):
	if velocity.x != 0 and (body.name == "Platform" or body.name == "Ground"):
			velocity.x = 0
			direction *= -1
	if body.name == "Player":
			body.do_damage(damage)

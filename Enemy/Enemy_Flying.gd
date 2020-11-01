extends KinematicBody2D

var player = null
onready var ray = $RayCast2D
export var speed = 200
export var looking_speed = 150
export var damage = 50


	
func _physics_process(_delta):
	if player == null:
		player = get_node_or_null("/root/Game/Player_Container/Player")
	else:
		ray.cast_to = ray.to_local(player.global_position)
		var c = ray.get_collider()
		if c:
			var velocity = ray.cast_to.normalized()*looking_speed
			if c.name == "Player":
				velocity = ray.cast_to.normalized()*speed
			move_and_slide(velocity, Vector2(0,0))



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.do_damage(damage)

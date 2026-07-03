extends CharacterBody2D


const SPEED = 150.0
var target_position

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var angular_speed = PI
	#rotation += angular_speed * delta # make the enemy turn in place
	# velocity = Vector2.UP.rotated(rotation) * SPEED # make the enemy velocity point up perpendicular of the rotation
	# position += velocity * delta # make the enemy move forward based on velocity
	# move_and_slide()
	pass


func _on_player_existed(player_position: Variant) -> void:
	target_position = (player_position - position).normalized()
	if position.distance_to(player_position) > 3:
		velocity = target_position*SPEED
		move_and_slide()
	if target_position.x < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false

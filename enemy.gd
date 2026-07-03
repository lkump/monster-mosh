extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var angular_speed = PI
	rotation += angular_speed * delta # make the enemy turn in place
	var velocity = Vector2.UP.rotated(rotation) * SPEED # make the enemy velocity point up perpendicular of the rotation
	position += velocity * delta # make the enemy move forward based on velocity
	move_and_slide()

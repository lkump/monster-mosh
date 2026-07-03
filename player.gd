extends CharacterBody2D


const SPEED = 300.0
signal existed(player_position)

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction := Input.get_axis("left", "right")
	if x_direction:
		velocity.x = x_direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var y_direction := Input.get_axis("up","down")
	if y_direction:
		velocity.y = y_direction * SPEED
	else: 
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		
	move_and_slide()
	existed.emit(position)


func _on_existed(player_position: Variant) -> void:
	print("x: ", player_position.x, " y: ", player_position.y)

extends CharacterBody2D


const SPEED = 150.0
var target_position

func _physics_process(delta: float) -> void:
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

extends State

@export var character: CharacterBody2D
@export var move_speed: int = 150
var follow_target : CharacterBody2D

func state_enter():
	follow_target = get_tree().get_first_node_in_group("Player")


func state_physics_process(_delta: float):
	var direction = follow_target.global_position-character.global_position
	if direction.length() < 200 and direction.length() > 50:
			character.velocity = direction.normalized()*move_speed
	else: character.velocity = Vector2.ZERO
	
	if direction.length() < 50:
		transitioned.emit(self,"attack")
	
	if direction.length() > 400:
		transitioned.emit(self, "idle")

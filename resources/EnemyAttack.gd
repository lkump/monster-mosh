extends State

@export var character: CharacterBody2D
@export var move_speed: int = 150
var attack_target : CharacterBody2D
@onready var animation_player : Node = $"../../AnimationPlayer"

func state_enter():
	attack_target = get_tree().get_first_node_in_group("Player")


func state_physics_process(_delta: float):
	var direction = attack_target.global_position-character.global_position
	if direction.length() < 50:
		animation_player.play("attack")
	else: transitioned.emit(self,"follow")

extends State
class_name EnemyIdle

var player : CharacterBody2D
@export var character : CharacterBody2D
const SPEED : float = 100.0

var wander_dir : Vector2
var wander_time : float


func state_enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()

func state_process(delta):
	if wander_time > 0:
		wander_time -= delta
	else: randomize_wander()
	
	var distance = player.global_position - character.global_position
	if distance.length() < 100:
		transitioned.emit(self,"follow")

func state_physics_process(_delta):
	character.velocity = wander_dir*SPEED


func randomize_wander():
	wander_dir = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)
	

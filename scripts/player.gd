extends CharacterBody2D

@export var stats : PlayerStatisticsResource
var speed
signal existed(player_position)
var attack_damage 
var health 

func _ready() -> void:
	speed = stats.speed
	health = stats.health
	attack_damage = stats.attack_damage
	
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction := Input.get_axis("left", "right")
	if x_direction:
		velocity.x = x_direction * speed
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	var y_direction := Input.get_axis("up","down")
	if y_direction:
		velocity.y = y_direction * speed
	else: 
		velocity.y = move_toward(velocity.y, 0, speed)
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	move_and_slide()
	existed.emit(position)
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		print("attacked with " + str(attack_damage) + " damage")
	

func _on_hurt_area_2d_area_entered(hit_area: HitArea2D) -> void:
	print("entered hit area")
	health = health - hit_area.damage
	print("took " + str(hit_area.damage) + " damage")
	print ("you have "+ str(health) + " HP left")

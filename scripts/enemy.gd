extends CharacterBody2D


const SPEED = 150.0
var target_position : Vector2

@onready var sprite = $Sprite2D
@export var attack_damage : int = 10
var wander_time : float
var wander_dir : Vector2
var speed : int = 100
var player : CharacterBody2D
var attack_scene : PackedScene = preload("res://scenes/area_attack.tscn")
var health : int = 10

func _ready() -> void:
	$ProgressBar.max_value = health

func _physics_process(delta: float) -> void:
	$ProgressBar.value = health
	if player:
		target_position = player.position
		if (target_position-position).length() > 20:
			velocity = (target_position-position).normalized() * speed
		else: velocity = Vector2.ZERO
		move_and_slide()
	else: wander(delta)
	animation()

func wander(delta):
	if wander_time > 0 and wander_dir != Vector2.ZERO :
		wander_time -= delta
		velocity = wander_dir*speed
	else: 
		wander_dir = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
		wander_time = randf_range(1,3)
	move_and_slide()

func animation():
	if velocity.x < 0 or (target_position-position < Vector2.ZERO and (target_position-position).length() < 25):
		sprite.flip_h = true
		sprite.offset.x = -21
	else: 
		sprite.flip_h = false
		sprite.offset.x = 21

func attack_body(body : CharacterBody2D):
	if body and body.has_method("take_damage"):
		body.take_damage(attack_damage, position)
		$AnimationPlayer.play("attack")

func take_damage(damage : int, _pos : Vector2 = Vector2.ZERO):
	health -= damage
	health = clamp(health,0,10)
	print("Enemy took " + str(damage) + " damage")
	print("Enemy has " + str(health) + " HP left")
	if health <= 0:
		die()

func die():
	queue_free()

func _on_detection_area_2d_body_entered(body: CharacterBody2D) -> void:
	player = body

func _on_detection_area_2d_body_exited(_body: CharacterBody2D) -> void:
	player = null

func _on_attack_area_2d_body_entered(body: CharacterBody2D) -> void:
	$AttackTimer.start()

func _on_attack_timer_timeout() -> void:
	if player:
		attack_body(player)



func _on_attack_area_2d_body_exited(body: Node2D) -> void:
	$AttackTimer.stop()

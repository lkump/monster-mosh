extends CharacterBody2D

@export var health: float = 10
@onready var health_bar = $ProgressBar

func _ready() -> void:
	health_bar.max_value = health

func _physics_process(_delta: float) -> void:
	move_and_slide()

func take_damage(amount: float, dir: Vector2 = Vector2.ZERO):
	change_health(-amount)
	print(health)
	take_knockback(dir)
	if health <= 0:
		die()
		

func die():
	queue_free()


func take_knockback(dir: Vector2):
	if dir == Vector2.ZERO:
		return
	else: 
		velocity = dir*200

func change_health(value: float):
	health += value
	health_bar.value = health

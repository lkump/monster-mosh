extends Area2D

var damage: int = 10: 
		set(value): damage = value
		get: return damage

func _ready() -> void:
	$LifeTimer.start()

func _on_life_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)

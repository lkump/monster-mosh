class_name HurtArea2D
extends Area2D

signal took_damage(amount)

func _on_area_entered(hit_area: HitArea2D) -> void:
	if hit_area != null:
		took_damage.emit(hit_area.damage)
	else:
		pass

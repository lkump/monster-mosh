class_name HurtArea2D
extends Area2D

func _ready() -> void:
	area_entered.connect(
		func _on_area_entered(hit_area: HitArea2D) -> void:
		var damage
		print("hit area entered hurt area")
		if hit_area and owner.has_method("take_damage"):
			damage = hit_area.damage
			owner.take_damage(damage, global_position)
	)

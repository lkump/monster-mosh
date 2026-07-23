extends Node2D

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(self,"scale",Vector2(1,1.05),.33)
	tween.tween_property(self,"scale",Vector2(1,1),.33)

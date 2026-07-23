extends Node2D

var area_attack_scene : PackedScene = preload("res://scenes/area_attack.tscn")
var enemy_scene : PackedScene = preload("res://scenes/enemy.tscn")

func _ready() -> void:
	var enemy = enemy_scene.instantiate() as CharacterBody2D
	enemy.position = Vector2(randf_range(0,get_viewport_rect().size.x),randf_range(0,get_viewport_rect().size.y))
	add_child(enemy)
	
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)

func _on_player_attacked(_damage: int, dir: Vector2, pos) -> void:
	var attack = area_attack_scene.instantiate() as Area2D
	attack.position = pos+ dir*100
	attack.look_at(pos+dir*1000)
	add_child(attack)
	


func _on_enemy_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate() as CharacterBody2D
	enemy.position = Vector2(randf_range(0,get_viewport_rect().size.x),randf_range(174,get_viewport_rect().size.y))
	add_child(enemy)


func _on_player_died() -> void:
	self.process_mode = Node.PROCESS_MODE_DISABLED

extends Node2D

@export_file('*.tscn') var change_scene
var puerta_on = false
@onready var puerta: StaticBody2D = $Button/Puerta

func _on_area_2d_body_entered(_body) -> void:
	get_tree().change_scene_to_file(change_scene)

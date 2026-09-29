extends CharacterBody2D
func _ready() -> void:
	$debug_lab.text = ""


func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("Hit!")
	$debug_lab.text = "Hit!"


func _on_area_2d_body_exited(_body: Node2D) -> void:
	$debug_lab.text = ""

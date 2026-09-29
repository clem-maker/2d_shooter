extends Node
var target_vec : Vector2
var bullet_lifetime : int = 5

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("uid://b0kxprreiuwlf")

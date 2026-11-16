extends Node
var target_vec : Vector2
var blickrichtung: bool #true = right,false = left
var player_position : Vector2




func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://main.tscn")
	

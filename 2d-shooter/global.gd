extends Node
var target_vec : Vector2
var blickrichtung: bool #true = right,flase = left
var instanz_bullet 





func destroy_bullet(bullet):
	if is_instance_valid(bullet):
		queue_free()



func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://main.tscn")

extends Node
var target_vec : Vector2
var blickrichtung: bool #true = right,false = left
var player_position : Vector2

var explosion_position : Vector2


func _ready() -> void:
		SignalBus.bullet_last_position.connect(a)

func a(bullet_pos_local):
	explosion_position = bullet_pos_local
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("uid://b0kxprreiuwlf")

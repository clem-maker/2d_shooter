extends CharacterBody2D
const SPEED : int = 250
var direction

func _ready() -> void:
	$debug_lab.text = ""
func _on_area_2d_body_entered(_body: Node2D) -> void:
	#print("Wurde getroffen")
	$debug_lab.text = "Wurde getroffen"
	#await get_tree().create_timer(.3).timeout
	#$debug_lab.text = ""
func _on_area_2d_body_exited(_body: Node2D) -> void:
	$debug_lab.text = ""
func get_direction() -> Vector2:
	var player_position = Global.player_position #ziel
	var gegner_position = position #position
	return player_position - gegner_position
func get_gegner_movment()->Vector2:
	if not abs(direction.length()) <1250: return Vector2.ZERO
	elif abs(direction.length()) > 340: return direction.normalized() * SPEED
	else :return -direction.normalized() * SPEED
func _physics_process(_delta: float) -> void:
	direction = get_direction()
	velocity = get_gegner_movment()
	move_and_slide()
		
	

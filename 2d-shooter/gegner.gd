extends CharacterBody2D
func _ready() -> void:
	$debug_lab.text = ""


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Wurde getroffen")
	$debug_lab.text = "Wurde getroffen"
	#await get_tree().create_timer(.3).timeout
	#$debug_lab.text = ""


func _on_area_2d_body_exited(body: Node2D) -> void:
	$debug_lab.text = ""

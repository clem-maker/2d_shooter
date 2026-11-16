extends Node2D
var expected_position_bullet : Vector2

func random_explosion_scale() -> Vector2:
	var random_scale = randf_range(.6,1.2)
	return Vector2(random_scale,random_scale)
func random_explosion_rotation()-> float:
	return randf_range(-360,360)
func random_explosion_offset()->Vector2:
	return Vector2(randf_range(-10,10),randf_range(-10,10))
func randomnis_explosion_combined() ->void:
	scale = random_explosion_scale()
	rotation = rad_to_deg(random_explosion_rotation())
	position += random_explosion_offset()
func play_explosion_animation_and_delete()-> void:
	get_node("explosion").play()
	await get_tree().create_timer(.20).timeout
	queue_free()

func _ready() -> void:
	Global.explosion_position = position
	randomnis_explosion_combined()
	play_explosion_animation_and_delete()

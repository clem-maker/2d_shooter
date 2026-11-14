extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shot"):
		spawn_bullet_at(get_global_mouse_position())
		
		
func spawn_bullet_at(mouse_position:Vector2):
	var target_indicator_instance = preload("uid://cneobvoiesig2").instantiate()
	var bullet_instance = preload("uid://dux0fglknt4sc").instantiate()
	bullet_instance.target_vec = mouse_position - $player/gun_shoot_point.global_position
	target_indicator_instance.position = mouse_position - Vector2(15,10)
	
	add_child(target_indicator_instance) #
	add_child(bullet_instance)
	
	if is_instance_valid(bullet_instance):
		bullet_instance.global_position = $player/gun_shoot_point.global_position
		bullet_instance.rotation = Global.target_vec.angle()

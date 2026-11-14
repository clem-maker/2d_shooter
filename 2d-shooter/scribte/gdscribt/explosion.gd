extends Node2D
var alpha_value_explosion : float = 3
func _ready() -> void:
	var sprite = $explosion_sprites
	sprite.material = sprite.material.duplicate()
func explosion_animation() -> void:
	#randomnis explosion
	scale = Vector2(randf_range(0.8,1.2),randf_range(0.8,1.4))
	rotation_degrees = randf_range(0,360)
	$explosion_sprites.speed_scale = randf_range(0.8,1.2)
	
	#play animation
	$explosion_sprites.play("explosion")
func _process(delta: float) -> void:
	get_node("explosion_sprites").material.set_shader_parameter("alpha_value",alpha_value_explosion)
	alpha_value_explosion -= delta *2
func explosion_finished() -> void:
	#destroy bullet + explosion
	get_parent().queue_free()

extends TextureRect

func _ready() -> void:
	material.set_shader_parameter("alpha_value",1)
	await get_tree().create_timer(.3).timeout
	var alha_tween : Tween = create_tween()
	alha_tween.tween_property(self,"material:shader_parameter/alpha_value",0.1,.2)

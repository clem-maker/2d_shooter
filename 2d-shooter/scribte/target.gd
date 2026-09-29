extends TextureRect
@export var target_despawn_time : float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(target_despawn_time).timeout
	queue_free()

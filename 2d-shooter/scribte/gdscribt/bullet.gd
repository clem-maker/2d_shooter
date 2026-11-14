extends RigidBody2D

signal explosion

const BULLET_MAX_TIME : float = 1

var visited : int = 0
var target_vec : Vector2
var explosion_instance : Node2D


func _ready() -> void:
	linear_velocity = target_vec
	$explosion_timer.start(BULLET_MAX_TIME)
func _physics_process(_delta: float) -> void:
	rotation = target_vec.normalized().angle()
func collision_detected() -> void:
	if visited <1:
		visited +=1
		print("explosion")
		explosion.emit()
		linear_velocity = Vector2.ZERO
func _on_explosion() -> void:
	$bullet_texture.hide()
	$explosion.show()

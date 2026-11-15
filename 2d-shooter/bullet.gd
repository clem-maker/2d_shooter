extends RigidBody2D
var start_position:Vector2
var now_postion:Vector2
var bullet_length:float
var max_despawn_time : float = .5
var direction_normelized : Vector2
@export var MIN_SPEED : int = 50
@export var MAX_SPEED : int = 1200
const SPEED : int = 2 # time to despawn
var time : float

func vec_length(dir:Vector2) ->float:
	return sqrt((dir.x**2)  +  (dir.y**2))
func _ready() ->void:
	var direction = (Global.target_vec)
	direction_normelized = Global.target_vec.normalized()
	start_position = global_position
	
	linear_velocity = direction*SPEED
	#despanwning bullet if Fehler:
	await get_tree().create_timer(max_despawn_time).timeout
	if is_instance_valid(self):
		queue_free()
	
	

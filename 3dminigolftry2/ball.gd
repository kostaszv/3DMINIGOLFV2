extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0
func _getVector2()->Vector2:
	return Vector2(position.z,position.y)
	
func _shoot(force,delta,input)->void:
	input.x = force
	apply_central_force(twist_pivot.basis* input * 45.0*delta)
func stoped() -> bool:
	var last_pos = position
	var new_pos = position
	if last_pos == new_pos:
		return true
	else:
		return false
	
@onready  var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input := Vector3.ZERO
	if stoped:
		rotation.x=0
		rotation.z=0
		rotation.y=0
	
	#input.x = Input.get_axis("move_back","move_forward")
	#input.z= Input.get_axis("move_left","move_right")
	
	
	
	
	
		
	
	
	
	apply_central_force(twist_pivot.basis* input * 660.0 *delta)
	
	
	#if Input.is_action_just_pressed("ui_cancel"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#twist_pivot.rotate_y(twist_input)
	#pitch_pivot.rotate_x(pitch_input)
	#pitch_pivot.rotation.x = clamp(
		#pitch_pivot.rotation.x,
		#-0.5 ,
		#0.5
		#)
	#twist_input = 0.0 
	#pitch_input = 0.0 
		#
#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
		#if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			#twist_input = - event.relative.x * mouse_sensitivity
			#pitch_input = - event.relative.y * mouse_sensitivity

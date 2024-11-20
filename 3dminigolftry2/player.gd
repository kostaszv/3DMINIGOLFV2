extends RigidBody3D

const dirch_Sensitivity = 25
const shoot_strength =100 
var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0
var force = 0 
var pressed = false
var time = 0
var progress_bar : ProgressBar
var right_bar: ProgressBar
var left_bar: ProgressBar
var input 
var direction = 50 
@onready var ball := $Ball
@onready  var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
@onready var aim := $Ball/AIM
var visible_aim = false 

func rotate_camera(twist_input,pitch_input)-> void:
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,
		-0.5 ,
		0.5
		)

func call_menu()-> void:		
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://main_menu.tscn")
	
	
func _calc_force(time)-> float:
	force = (time/2.0)*shoot_strength
	update_progressbar(force)
	
	return force
	
func update_progressbar(force)-> void:
	progress_bar.value = force
	
func show_aim() -> void:
	aim.invisible(true)

func hide_aim()->void:
	aim.invisible(false)
	
func _ready() -> void:
	
	progress_bar = $"User interface/Force"
	right_bar = $"User interface/RIGHT"
	left_bar = $"User interface/LEFT"
	progress_bar.value = 0  # Initialize the progress bar value to 0
	right_bar.value = 0
	left_bar.value =0 
	hide_aim()

func init_direction(input)->Vector3:
	input.z = 0 
	return input

func calc_direction(input) -> Vector3:
	if Input.is_action_pressed("move_left"):
		aim_left()
		input.z -= dirch_Sensitivity
		left_bar.value += dirch_Sensitivity
	elif  Input.is_action_pressed("move_right"):
		aim_right()
		input.z =  dirch_Sensitivity + input.z
		right_bar.value += dirch_Sensitivity
		print(input.z)
	return input
	
func aim_left()->void:
	set_aim(0.1)
func aim_right()->void:
	set_aim(-0.1)

	
func set_aim(degrees :float)->void:
	aim.rotate_y(degrees)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = -1 + ball.position.x
	position.y = ball.position.y +10
	position.z = ball.position.z
	aim.set_position(Vector3(0,0,0))
	if Input.is_action_just_pressed("force"):
		input = Vector3.ZERO
		input = calc_direction(input)
		time +=delta
		pressed = true 
		force = _calc_force(time)
		show_aim()
	if pressed:
		input.z= 0.0
		input = calc_direction(input)
		time+=delta
		if time < 2.0:
			_calc_force(time)
			
	if Input.is_action_just_released("force") and pressed == true :
		pressed = false
		hide_aim()
		input = calc_direction(input)
		ball._shoot(force,delta,input)
		time = 0 
		_calc_force(time)
		update_progressbar(force)
		right_bar.value = 0 
		left_bar.value = 0 
	if Input.is_action_just_pressed("ui_cancel"):
		call_menu()
	rotate_camera(twist_input,pitch_input)

		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity

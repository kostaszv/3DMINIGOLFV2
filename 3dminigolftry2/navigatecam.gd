extends Node3D

var force = 0 
var pressed = false
var time = 0
var progress_bar : ProgressBar
@onready var AIM : Node3D  = $PLAYER/AIM

func _calc_force(time) -> void:
	force = (time/2.0)*100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AIM.visible = false
	progress_bar = $ProgressBar
	progress_bar.value = 0  # Initialize the progress bar value to 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("force"):
		print("pressed")
		AIM.visible = true
		pressed = true 
		time +=delta
		_calc_force(time)
		progress_bar.value = force
		print(time,"pressed")
		
	if pressed:
		AIM.visible = true
		time+=delta
		if time < 2.0:
			_calc_force(time)
			progress_bar.value = force
			
	if Input.is_action_just_released("force") and pressed == true :
		pressed = false
		print(time,"release")
		time = 0 
		_calc_force(time)
		progress_bar.value = force
		AIM.visible = false
		
		
		

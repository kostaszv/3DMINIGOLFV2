extends CenterContainer
@onready var appear = false 
@export var dot_radius: float = 2.0 
@export var dot_color: Color = Color.RED
@onready var ballpos : Vector2 = $"../../Ball"._getVector2()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()
	
func aiming()->void:
	ballpos = $"../../Ball"._getVector2()
	if Input.is_action_just_pressed("force"):
		draw_circle(ballpos,dot_radius,dot_color)
		print("showing")
		appear= true
	if appear:
		draw_circle(ballpos,dot_radius,dot_color)
		print("showing")
	if Input.is_action_just_released("force"):
		appear = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	


func _draw() -> void:
	aiming()
	
	

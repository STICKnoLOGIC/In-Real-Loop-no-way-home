extends CharacterBody2D

@onready var treeAnim=$AnimationTree
@onready var light=$PointLight2D
@export var speed : float = 6000

var speed_var=1
var Velocity
var normalized_mouse
var Dir : int = 400

func _ready():
	if Default.SpawnAbove:
		Dir = -440	
	global_position=Vector2(Default.playerPosX, Dir)

func _physics_process(delta):
	light.look_at(get_global_mouse_position())
	
	Velocity=Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	normalized_mouse=global_position.direction_to(get_global_mouse_position())
	
	if Velocity != Vector2.ZERO:
		treeAnim.get("parameters/playback").travel("walk")
		treeAnim.set( "parameters/walk/blend_position",normalized_mouse)
		
		if abs(normalized_mouse.x) > abs(normalized_mouse.y):
			if normalized_mouse.x > 0:
				if Velocity.x > 0:
					speed_var=1
				elif Velocity.x < 0:
					speed_var=0.65
				else:
					speed_var=.75
			else:
				if Velocity.x < 0:
					speed_var=1
				elif Velocity.x > 0:
					speed_var=0.65
				else:
					speed_var=.75
		else:
			if normalized_mouse.y < 0:
				if Velocity.y < 0:
					speed_var=1
				elif Velocity.y > 0:
					speed_var=0.65
				else:
					speed_var=.75
			else:
				if Velocity.y > 0:
					speed_var=1
				elif Velocity.y < 0:
					speed_var=0.65
				else:
					speed_var=.75
		velocity=Velocity*speed*delta*speed_var
		move_and_slide()
		
	else:
		treeAnim.get("parameters/playback").travel("idle")		
		treeAnim.set( "parameters/idle/blend_position",normalized_mouse) 

func getGhostPosition():
	if abs(normalized_mouse.x) > abs(normalized_mouse.y):
			if normalized_mouse.x > 0:
				return 0
			else:
				return 1
	else:
			if normalized_mouse.y < 0:
				return 2
			else:
				return 3

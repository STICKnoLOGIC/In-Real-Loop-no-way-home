extends Area2D

var Dir: int = 1
var Speed:int = 30

func _ready():
	$audio.play()
	if not Default.SpawnAbove:
		Dir = -1
		global_position=Vector2(0,-400)
		$AnimationPlayer.current_animation="walkDown"
	else:
		Dir = 1
		global_position=Vector2(0,400)
		$AnimationPlayer.current_animation="walkUp"		

func _physics_process(delta):
	position+=Vector2.UP *delta * Speed *Dir

func makeItAbno():
	match randi_range(0,2):
		0:
			$audio.stream = preload("res://Resources/snl_res/uncle_tomi_abno.wav")
			$audio.volume_db=0
			$audio.play()
			pass
		1:
			Speed+=randi_range(5,15)
			pass
		2:
			Speed-=randi_range(5,15)
			pass

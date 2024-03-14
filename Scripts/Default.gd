extends Node2D

var transitionColor : Color = Color.BLACK
var SpawnAbove : bool = false
var path : int = 1
var playerPosX : int = 0

func _ready():
	DisplayServer.window_set_title("IRL: no way home")

func setPlayerPosX(pos:int):
	playerPosX=pos
	
func nextPath(above : int):
	$CanvasLayer/ColorRect.color=Color.BLACK
	get_tree().paused=true
	SpawnAbove=bool(above)
	path-=1
	print(path)
	if path <= 0:
		Winner()
	else:
		$AnimationPlayer.current_animation="close"
		get_tree().reload_current_scene()

func repeatPath(above : int):
	$CanvasLayer/ColorRect.color=Color.BLACK
	get_tree().paused=true
	$AnimationPlayer.current_animation="close"	
	path=8
	SpawnAbove=bool(above)
	get_tree().reload_current_scene()
	
func open():
	$CanvasLayer/level.text= 'Path '+var_to_str(path)
	$AnimationPlayer.current_animation="open"
	
func Winner():
	get_tree().paused=true
	$CanvasLayer/ColorRect.color=Color.WHITE
	$CanvasLayer/label1.visible=true
	$AnimationPlayer.current_animation="open_2"

func MainMenu():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func resumeApp():
	get_tree().paused=false

func playBGM():
	if not $bgm.playing:
		$bgm.play()



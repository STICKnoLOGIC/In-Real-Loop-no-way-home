extends Node2D

@export var startRand : Vector2
@export var endRand : Vector2
@onready var randomObject=preload("res://Scenes/Abnormalities/randomObject.tscn")
@onready var warning1=preload("res://Scenes/Abnormalities/NormalWarning.tscn")
@onready var warning2=preload("res://Scenes/Abnormalities/TriggeredWarning.tscn")
@onready var ghost=preload("res://Scenes/Abnormalities/Ghost.tscn")


var isAbno=bool(randi_range(0,1))

func _ready():
	get_tree().paused=false
	randomize()
	Default.playBGM()
	if isAbno:
		match randi_range(0,5):
			1:
				spawn_random_object()
				pass
			2:
				$UncleTomi.makeItAbno()
				pass
			3:
				add_child(warning1.instantiate())
				pass
			4:
				Warning2()
				pass
			5:
				Ghosting()
	Default.open()
	
func _input(event):
	if event is InputEventKey and  Input.is_key_label_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")
		

# Abnormalities
func spawn_random_object():
	var object_count=randi_range(2,6)
	for i in object_count:
		var object=randomObject.instantiate()
		object.position=Vector2(randf_range(startRand.x,endRand.x),randf_range(startRand.y,endRand.y))
		add_child(object)

func Warning2():
	var warn=warning2.instantiate()
	add_child(warn)
	warn.setTarget($Player)
	warn.setPurpose(randi_range(0,1))
		
func Ghosting():
	var g = ghost.instantiate()
	g.setTarget($Player)
	add_child(g)
	match randi_range(0,1):
		0:
			g.global_position=Vector2(-340,0)
			g.setPurpose(0)
			pass
		1:
			g.global_position=Vector2(340,0)
			g.setPurpose(2)
			pass


func _on_bottom_exit_body_entered(body):
	if body.name == "Player":
		Default.setPlayerPosX($Player.global_position.x)		
		if isAbno:
			if Default.SpawnAbove:
				print("repeat")
				Default.repeatPath(1)
			else:
				print("next")
				Default.nextPath(1)
		else:
			if not Default.SpawnAbove:
				print("repeat")
				Default.repeatPath(1)
			else:
				print("next")
				Default.nextPath(1)


func _on_above_exit_body_entered(body):
	if body.name == "Player":
		Default.setPlayerPosX($Player.global_position.x)		
		if isAbno:
			if not Default.SpawnAbove:
				print("repeat")
				Default.repeatPath(0)
			else:
				print("next")
				Default.nextPath(0)
		else:
			if Default.SpawnAbove:
				print("repeat")
				Default.repeatPath(0)
			else:
				print("next")
				Default.nextPath(0)


func _on_bottom_exit_area_entered(area):
	if area.name == "UncleTomi":
		area.queue_free()

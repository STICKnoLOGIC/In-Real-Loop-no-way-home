extends Node2D

func _ready():
	Default.playBGM()

func _input(event):
	if event is InputEventKey and Input.is_key_label_pressed(KEY_ESCAPE):
		get_tree().quit()

func _on_mech_pressed():
	$sfx.play()
	$CanvasLayer/m.visible = not $CanvasLayer/m.visible
	$CanvasLayer/mech.visible = not $CanvasLayer/m.visible
	$CanvasLayer/credits.visible = not $CanvasLayer/m.visible
	$CanvasLayer/Play.visible = not $CanvasLayer/m.visible


func _on_x_pressed():
	$sfx.play()
	$CanvasLayer/m.visible = not $CanvasLayer/m.visible
	$CanvasLayer/mech.visible = not $CanvasLayer/m.visible
	$CanvasLayer/credits.visible = not $CanvasLayer/m.visible
	$CanvasLayer/Play.visible = not $CanvasLayer/m.visible


func _on_credits_pressed():
	$sfx.play()
	$CanvasLayer/m2.visible = not $CanvasLayer/m2.visible
	$CanvasLayer/mech.visible = not $CanvasLayer/m2.visible
	$CanvasLayer/credits.visible = not $CanvasLayer/m2.visible
	$CanvasLayer/Play.visible = not $CanvasLayer/m2.visible


func _on_x_2_pressed():
	$sfx.play()
	$CanvasLayer/m2.visible = not $CanvasLayer/m2.visible
	$CanvasLayer/mech.visible = not $CanvasLayer/m2.visible
	$CanvasLayer/credits.visible = not $CanvasLayer/m2.visible
	$CanvasLayer/Play.visible = not $CanvasLayer/m2.visible


func _on_play_pressed():
	Default.path=8
	get_tree().change_scene_to_file("res://Scenes/Easy_Map.tscn")

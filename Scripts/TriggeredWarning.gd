extends Node2D

var purpose
var triggered = false
var target : Node2D

@onready var Ghost=preload("res://Scenes/Abnormalities/Ghost.tscn")

func setTarget(player):
	target=player

func setPurpose(use):
	purpose=use
	match use:
		0: # rats
			$NormalWarning.region_rect.position.y=256
			pass
		1: #ghost
			$NormalWarning.region_rect.position.y=512
			
			pass


func _on_area_2d_area_entered(area):
	if triggered:
		return	
	print(area)
	if area.name == "PlayerSight":
		triggered=true
		match purpose:
			0:
				pass
			1:
				if target:
					var gy=-128
					var lookingDown=target.get_parent().global_position.direction_to(get_global_mouse_position()).y<0
					if lookingDown:
						gy=128
					var g1=Ghost.instantiate()
					g1.setTarget(target)
					g1.setPurpose(1)
					get_parent().add_child(g1)
					g1.global_position=Vector2(target.get_parent().global_position.x + 128, target.get_parent().global_position.y + gy)
					
					var g2=Ghost.instantiate()
					g2.setTarget(target)
					g2.setPurpose(1)
					get_parent().add_child(g2)
					g2.global_position=Vector2(target.get_parent().global_position.x - 128, target.get_parent().global_position.y + gy)
				

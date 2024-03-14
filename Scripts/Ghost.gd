extends CharacterBody2D

@onready var treeAnim = $AnimationTree
var speed = 7000
var target : Node2D
var canChase : bool = false
var purpose : int #0 = scare_idle ; 1 = scare_when_looked ; 2 = scare_when_agro

func setTarget(player):
	target=player

func setPurpose(use : int):
	purpose=use
	match use:
		0:
			$Agro.visible=true
			$sfx.stream=preload("res://Resources/snl_res/ghost_1.wav") # turn back			
			pass
		1:
			$Agro.visible=false
			speed*=1.75
			$sfx.autoplay=true
			$sfx.stream=preload("res://Resources/snl_res/devil_ghost.wav") # laughing ghost
			$sfx.volume_db=-15
			$sfx.pitch_scale=0.8
			$sfx.play()
			pass
		2:
			$sfx.stream=preload("res://Resources/snl_res/ghost_2.wav") # run sfx
			pass
	


func _physics_process(delta):
	if target:
		if purpose == 1:
			var ypos =  global_position.y - target.global_position.y 
			global_position=Vector2(global_position.x,target.global_position.y)
		
		var targetDir : Vector2 = global_position.direction_to(target.global_position)
		treeAnim.set( "parameters/blend_position",targetDir)
		if canChase:
			velocity=targetDir*delta*speed
			move_and_slide()



func _on_sfx_finished():
	if purpose == 2:
		canChase=true
	pass # Replace with function body.


func _on_bite_area_entered(area):
	if area.name == "PlayerSight" and purpose == 1:
		canChase=true
		$sfx.play()
		pass
	pass # Replace with function body.


func _on_bite_body_entered(body):
	if body.name == "Player" and (purpose == 1 or purpose == 2):
		print("GameOver")
		Default.repeatPath(Default.SpawnAbove)
	


func _on_agro_body_entered(body):
	if body.name == "Player" and purpose == 2:
		$sfx.play()
	

extends Node2D

@export var index : PackedVector2Array

var current: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	current = index[randi_range(0,index.size()-1)]
	$object.region_rect.position=Vector2.ZERO + (current*16)

extends Node2D


export var angle_max = 20
export var angle_min = -35

export var is_activated = false




# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_degrees = angle_min


func _input(_event):
	if Input.is_action_pressed("left_paddle"):
		print("left_paddle" )

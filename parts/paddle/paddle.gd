extends Node2D
"""
paddle object
-------------
- connect to a paddle-control button
- have custom animatons
- have custom graphics
- have custom collision effects

editor-interactive tools:
How to Create a 2d Manipulator in Godot 3.1: Editor Plugin Overview
https://www.youtube.com/watch?v=H6TfKYtuM9U&t=5s&ab_channel=GDQuest
Drawing in Viewport in Godot: Plugin Tutorial 1 
https://www.youtube.com/watch?v=nSqaIY-eJm0&ab_channel=GDQuest
"""

enum SIDEDNESS { left,right,either }
export(SIDEDNESS) var sidedness = SIDEDNESS.left

export var angle_max = 20
export var angle_min = -45

export var on_speed = 1000.0 # degrees per second?
export var off_speed = 300.0


export var is_activated = false



# Called when the node enters the scene tree for the first time.
func _ready():

	if sidedness == SIDEDNESS.left:
		get_node("pivot/KinematicBody2D/Polygon2D").set_scale(Vector2( -1, 1 ))
		var _x = get_node("pivot/KinematicBody2D/CollisionShape2D").get_position().x
		get_node("pivot/KinematicBody2D/CollisionShape2D").set_position(Vector2( -1 * _x ,1))
		
		rotation_degrees = - angle_min
#		var _amax = angle_max
#		var _amin = angle_min
#		angle_max = _amin * -1 
#		angle_min = _amax * -1
		angle_max *= -1
		angle_min *= -1
		print("left paddle min %s  max %s (%s)"%[angle_min, angle_max, get_rotation_degrees()])


	if sidedness == SIDEDNESS.right:
		rotation_degrees = angle_min
#		angle_max = 0.0
#		angle_min = 0.0

func _input(_event):
	if sidedness == SIDEDNESS.left:
		if Input.is_action_just_pressed("left_paddle"):
			if !is_activated:
				print("left_paddle activate" )
				is_activated = true

		if Input.is_action_just_released("left_paddle"):
				is_activated = false
				print("left_paddle deactivated" )

	if sidedness == SIDEDNESS.right:
		if Input.is_action_just_pressed("right_paddle"):
			if !is_activated:
				print("right_paddle activate" )
				is_activated = true

		if Input.is_action_just_released("right_paddle"):
				is_activated = false
				print("right_paddle deactivated" )



func _physics_process(dt):
	#print("rd",self.rotation_degrees)
	
	if is_activated:
		if sidedness == SIDEDNESS.right:
			self.rotation_degrees += on_speed * dt
		elif  sidedness == SIDEDNESS.left:
			self.rotation_degrees -= on_speed * dt

	if sidedness == SIDEDNESS.right:
		if self.rotation_degrees > angle_max:
			self.rotation_degrees = angle_max
	elif sidedness == SIDEDNESS.left:
		if self.rotation_degrees < angle_max:
			self.rotation_degrees = angle_max

	if is_activated == false:
		if sidedness == SIDEDNESS.right:
			self.rotation_degrees -= off_speed *dt
			if self.rotation_degrees < angle_min:
				self.rotation_degrees = angle_min

		elif sidedness == SIDEDNESS.left:
			self.rotation_degrees += off_speed *dt
			if self.rotation_degrees > angle_min:
				self.rotation_degrees = angle_min



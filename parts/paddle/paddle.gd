tool
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

enum SIDEDNESS { left,right }
export(SIDEDNESS) var sidedness = SIDEDNESS.left setget sidedness_setget

var angle_max := 0.0
export var angle_min = -45 setget setget_angle_min
export var angle_range = 45 setget setget_angle_range
export(float, 0.1, 300) var length := 110.0 setget setget_length
export(float, 0.1, 100) var radius := 10.0 setget setget_radius
export var on_speed = 1000.0 # degrees per second?
export var off_speed = 300.0

var is_activated = false

onready var _debug_font = Control.new().get_font("")

# debug drawing things
var _debug_angle_range_text_position = Vector2.ZERO
var _arc_colour = Color(0.294067, 0.855469, 0.350207, .25)
var _arc_angele_text_colour = Color(0.294067, 0.855469, 0.350207, .55)
var _arc_range_line_colour = Color(0.589844, 0.534546, 0.368652, 0.870588)

#physics shape
onready var collision_shape = get_node("pivot/KinematicBody2D/CollisionShape2D")


func _ready():
	angle_max = angle_min + angle_range
	_update_paddle_geometry()
	collision_shape.shape = collision_shape.shape.duplicate()


func _input(_event):
	if sidedness == SIDEDNESS.left:
		if Input.is_action_just_pressed("left_paddle"):
			if !is_activated:
				is_activated = true
		if Input.is_action_just_released("left_paddle"):
				is_activated = false
	if sidedness == SIDEDNESS.right:
		if Input.is_action_just_pressed("right_paddle"):
			if !is_activated:
				is_activated = true
		if Input.is_action_just_released("right_paddle"):
				is_activated = false


func _physics_process(dt):
	if is_activated:
		if angle_range > 0.0:
			self.rotation_degrees += on_speed * dt
		else:
			self.rotation_degrees -= on_speed * dt

	if angle_range > 0.0:
		if self.rotation_degrees > angle_max:
			self.rotation_degrees = angle_max
	else:
		if self.rotation_degrees < angle_max:
			self.rotation_degrees = angle_max

	if is_activated == false:
		if angle_range > 0.0:
			self.rotation_degrees -= off_speed *dt
			if self.rotation_degrees < angle_min:
				self.rotation_degrees = angle_min

		else:
			self.rotation_degrees += off_speed *dt
			if self.rotation_degrees > angle_min:
				self.rotation_degrees = angle_min


func _process(_delta):
	if Engine.is_editor_hint():
		update()


func _draw():
	if Engine.is_editor_hint():
		draw_arc(Vector2.ZERO, length + 5.0, 0, deg2rad(angle_range), 32, _arc_colour, 2.0, true)
		var _ar = str(angle_range)
		draw_string(_debug_font, Vector2(length/2.0, 5.0), SIDEDNESS.keys()[sidedness], _arc_angele_text_colour)

		# negate rotation
		draw_set_transform ( Vector2.ZERO, -1* self.rotation, Vector2.ONE )
		draw_line(_debug_angle_range_text_position * 0.2 , _debug_angle_range_text_position*0.9 , _arc_colour, 1.0, true) 
		draw_string(_debug_font, _debug_angle_range_text_position, _ar+"°", _arc_angele_text_colour)


func setget_length(new_value) -> void:
	length = new_value
	_debug_angle_range_text_position = Vector2(length - radius, 0.0).rotated( deg2rad(angle_range) + self.rotation )
	_update_paddle_geometry()


func setget_radius(new_value) -> void:
	radius = new_value
	_debug_angle_range_text_position = Vector2(length, 0.0).rotated( deg2rad(angle_range) + self.rotation )
	_update_paddle_geometry()


func setget_angle_min(new_value) -> void:
	print("setget_angle_min -> %s"% [new_value])
	angle_min = new_value
	angle_max = angle_min + angle_range
	_debug_angle_range_text_position = Vector2(length, 0.0).rotated( deg2rad(angle_range) + self.rotation )
	_update_paddle_geometry()


func setget_angle_range(new_value) -> void:
	angle_range = new_value
	angle_max = angle_min + angle_range
	_debug_angle_range_text_position = Vector2(length , 0.0).rotated( deg2rad(angle_range) + self.rotation )
	print("setget_angle_range -> %s (new max %s)"%[new_value, angle_max])


func sidedness_setget(new_value) -> void:
	print("sidedness_setget -> [%s]"%[ SIDEDNESS.keys()[new_value] ])
	sidedness = new_value
	_update_paddle_geometry()


func _update_paddle_geometry() -> void:
	if is_instance_valid(collision_shape):
		collision_shape.set_position(Vector2( length/2.0 - radius/2.0 ,0.0))
		collision_shape.get_shape().radius = radius
		collision_shape.get_shape().height = length - radius
		




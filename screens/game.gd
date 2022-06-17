extends Node2D
"""

"""

onready var first_level = load("res://levels/test_level.tscn")

var window_size = Vector2.ZERO

var balls = []

var current_level := Node2D

func _ready():
	var _ws = OS.get_window_size()
	window_size = _ws
	print("game window size %s"%_ws)
	print("setting " + $ViewportContainer/Viewport.get_path()+"'s resolution to %s"%[_ws])
	$ViewportContainer/Viewport.set_size( Vector2( _ws.x, _ws.y ))
	switch_level( first_level )


func _process(_delta):
	$fps_label.text = str(Engine.get_frames_per_second())


func _input(_event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()


func get_current_level():
	return self.current_level


func switch_level( level ) -> void :
	print("switch level %s"%str(level) )
	var lvl = level.instance()
	current_level = lvl
	$ViewportContainer/Viewport.add_child(lvl)

	#===========================================================================
	# find balls, tell camera
	print(".. find balls")
	balls = []
	for c in lvl.get_children():
		if c.get_class() == "Pinball":
			balls.append(c)
	
	if len(balls) > 0:
		print("found %s balls (%s)"%[len(balls), balls])

	for b in balls:
		$ViewportContainer/Viewport/Camera2D.add_tracked_object(b)

	$ViewportContainer/Viewport/Camera2D/balls_hull.balls = balls
	#===========================================================================

	

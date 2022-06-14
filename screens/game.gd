extends Node2D
"""

"""

onready var level = load("res://levels/test_level.tscn")

func _ready():
	var _ws = OS.get_window_size()
	print("game window size %s"%_ws)
	
	print("setting " + $ViewportContainer/Viewport.get_path()+"'s resolution to %s"%[_ws])
	$ViewportContainer/Viewport.set_size( _ws )
	switch_level( level )


func _process(delta):
	#$fps_label.text = str(Performance.get_monitor(Performance.TIME_FPS))
	$fps_label.text = str(Engine.get_frames_per_second())


func switch_level( level ) -> void :
	print("switch level %s"%str(level) )
	var lvl = level.instance()
	$ViewportContainer/Viewport.add_child(lvl)

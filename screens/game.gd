extends Node2D
"""

"""

onready var first_level = load("res://levels/test_level.tscn")

var window_size = Vector2.ZERO

var balls = []
var bumpers = []

var current_level := Node2D

var points := 0.0
 

func _ready():
	var _ws = OS.get_window_size()
	window_size = _ws
	print("game window size %s"%_ws)
	print("setting " + $ViewportContainer/Viewport.get_path()+"'s resolution to %s"%[_ws])
	$ViewportContainer/Viewport.set_size( Vector2( _ws.x, _ws.y ))
	switch_level( first_level )
	$hud/score_label.text = "-"

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
	# find objects in level
	print(".. find balls")
	balls = []
	bumpers = []
	for c in lvl.get_children():
		#if c.get_class() == "Pinball":
		if "is_pinball" in c:
			balls.append(c)
		elif c.get_class() == "Bumper":
			bumpers.append(c)
	
	if len(balls) > 0:
		print("found %s balls (%s)"%[len(balls), balls])

	for b in balls:
		$ViewportContainer/Viewport/Camera2D.add_tracked_object(b)

	$ViewportContainer/Viewport/Camera2D/balls_hull.balls = balls
	#===========================================================================

	# connnect to bumper signals
	for b in bumpers:
		b.connect("score_points", self, "_on_score_points")


func _on_score_points( object, n_points):
	print("[game] score %s points from %s "%[ n_points, object.get_name() ])
	self.points += n_points
	$hud/score_label.text = format_score(str(self.points))


# https://godotengine.org/qa/18559/how-to-add-commas-to-an-integer-or-float-in-gdscript
func format_score(score : String) -> String:
	var i : int = score.length() - 3
	while i > 0:
		score = score.insert(i, ",")
		i = i - 3
	return score

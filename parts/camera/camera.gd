extends Camera2D


var tracked_objects = []
var centre = Vector2.ZERO


func _ready():
	centre = Vector2( OS.get_window_size()/2.0 )


func _process(_delta):
	var _c := Vector2.ZERO
	for o in tracked_objects:
		_c += o.position
	centre = _c / len(tracked_objects)
	self.position = centre


func add_tracked_object(object) -> void:
	print("[camera] add_tracked_object")
	if !tracked_objects.has(object):
		print("[camera]   add > %s"%object)
		tracked_objects.append(object)





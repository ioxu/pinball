extends Camera2D


export var zoom_speed = 0.1

var tracked_objects = []
var centre = Vector2.ZERO
var zoom_factor := 1.0
var _raw_zoom_factor := 1.0
var balls_bbox := Rect2()


func _ready():
	centre = Vector2( OS.get_window_size()/2.0 )
	balls_bbox = $balls_hull.bbox


func _process(_delta):
	var _c := Vector2.ZERO
	for o in tracked_objects:
		_c += o.position
	centre = _c / len(tracked_objects)
	self.position = centre

	# zoom
	balls_bbox = $balls_hull.bbox
	_raw_zoom_factor = remap( max( balls_bbox.size.x, balls_bbox.size.y ) , 90, 1000, 0.75, 2.0 )
	zoom_factor = lerp(zoom_factor, _raw_zoom_factor, zoom_speed * _delta)
#	print("zoom %s (raw %s)"%[zoom_factor, _raw_zoom_factor])
	self.zoom = Vector2.ONE * zoom_factor


func add_tracked_object(object) -> void:
	if !tracked_objects.has(object):
		print("[camera]   add tracked object > %s"%object)
		tracked_objects.append(object)


func remap( f, start1, stop1, start2, stop2):
	return start2 + (stop2 - start2) * ((f - start1) / (stop1 - start1))


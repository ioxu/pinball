extends Node2D
"""
calculates the convex hull and the bounding box of the balls
"""
export var do_draw := false
export var calc_convex_hull = false

var balls := []
var balls_points_pool_array : PoolVector2Array
const MAX_COORD = pow(2,31)-1
const MIN_COORD = -MAX_COORD
var top_left = Vector2()
var bottom_right = Vector2()
var largest_dimension := 1.0

var convex_hull := PoolVector2Array()
var bbox := Rect2()


func _ready():
	pass


func _process(_delta):
	if len(balls) > 0 and self.is_visible_in_tree():
		update()
		balls_points_pool_array = PoolVector2Array()
		top_left = Vector2(MAX_COORD,MAX_COORD)
		bottom_right = Vector2(MIN_COORD,MIN_COORD)
		for b in balls:
			var _p = b.get_position()
			balls_points_pool_array.append( _p )
			top_left = minv( top_left, _p )
			bottom_right = maxv( bottom_right, _p )
		bbox = Rect2( top_left, bottom_right-top_left )
		if calc_convex_hull:
			convex_hull = Geometry.convex_hull_2d(balls_points_pool_array)


func _draw():
	if len(balls) > 0 and self.is_visible_in_tree():
		draw_set_transform_matrix(get_global_transform().inverse())
		if len(convex_hull) > 3 and calc_convex_hull:
			draw_colored_polygon(convex_hull, Color(1,1,1,0.12))
		draw_rect(bbox, Color(0.811765, 0.666667, 0.27451, 0.25), false, 3.0 * get_node("../").zoom_factor)


#https://www.reddit.com/r/godot/comments/b0r9l4/is_it_possible_to_get_the_bounding_box_of_a/
func minv(curvec,newvec):
	return Vector2(min(curvec.x,newvec.x),min(curvec.y,newvec.y))


func maxv(curvec,newvec):
	return Vector2(max(curvec.x,newvec.x),max(curvec.y,newvec.y))






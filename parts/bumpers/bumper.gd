extends Area2D
class_name Bumper

export var force := 60000.0
export(Color, RGB) var flash_color = Color(1.0, 0.0, 0.0)
export var hit_score := 123

var fx_time := 0.0
var fx_fade_speed := 5.5


signal score_points(this_bumper, n_points)


func get_class():
	return "Bumper"


func _ready():
	pass


func _physics_process(delta):
	for b in self.get_overlapping_bodies():
		if b.get_class() == "Pinball":
			_on_bumper_body_entered( b )
			emit_signal( "score_points", self, self.hit_score )
			fx_time = 1.0
	if fx_time > 0.0:
		fx_time -= fx_fade_speed * delta
		update()


func _draw():
	if fx_time > 0.0:
		draw_arc( Vector2.ZERO,
			32-(15/2),
			0.0,
			deg2rad(359),
			32,
			Color(flash_color.r, flash_color.g, flash_color.b, fx_time)*2,
			15)


func _on_bumper_body_entered( body ):
	if body.get_class() == "Pinball":
		var _id = body.get_global_position() - self.get_global_position()
		_id = _id.normalized() * force

		# kill a bit of existing velocity
		body.set_linear_velocity( body.get_linear_velocity() * 0.5 )
		
		# apply bumper impulse
		body.apply_central_impulse( _id )




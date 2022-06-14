extends Node2D


func _ready():
	$engine_version.text = Engine.get_version_info().string


func _input(event):
	if event is InputEventKey or event is InputEventJoypadButton:
		if event.pressed:
			start()
			

func start() -> void:
	print("exit splash -> start game")
	var _cs = get_tree().change_scene("res://screens/game.tscn")
	print("splash.tcsn change_scene: %s"%_cs)

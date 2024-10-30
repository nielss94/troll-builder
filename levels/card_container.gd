extends Node2D

var mouse_present: bool
var tween: Tween

func _process(delta):
	
	#var mouse_pos = get_global_mouse_position()
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_center_x = get_viewport_rect().size.x / 2 
	var relative_mouse_x = mouse_pos.x -screen_center_x
	
	if mouse_present:
		position.x =  - relative_mouse_x * 0.40


func _on_area_2d_mouse_entered():
	if tween:
		tween.kill()
	tween = create_tween()
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_center_x = get_viewport_rect().size.x / 2 
	var relative_mouse_x = mouse_pos.x -screen_center_x
	tween.tween_property(self, "position", Vector2(- relative_mouse_x * 0.40, 0), 1)
	mouse_present = true # Replace with function body.



func _on_area_2d_mouse_exited():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "position", Vector2(0, 0), 0.1)
	mouse_present = false # Replace with function body.

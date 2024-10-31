extends Area2D

# HandSlot properties for width, height, and index
var width := 100.0
var height := 100.0
var index := 0
var rects = []

func _draw():
	for r in rects: 
		draw_rect(r,Color.AQUA,false,1)
		
# Initialize the slot with dimensions and index
func setup_slot(slot_width: float, slot_height: float, slot_index: int):
	width = slot_width
	height = slot_height
	index = slot_index
	
	# Set the collision shape
	var collision_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(width / 2.0, height / 2.0)
	collision_shape.shape = shape
	add_child(collision_shape)
	rects.append(shape.get_rect())
	queue_redraw()


	
	# Add a label to display the index
	var label = Label.new()
	label.text = str(index)
	label.size = Vector2(width, height)
	#label.horizontal_alignment = Label.ALIGN_CENTER
	#label.vertical_alignment = Label.VALIGN_CENTER
	add_child(label)
	
	# Connect mouse enter and exit signals
	connect("mouse_entered", _on_mouse_entered)



# Signal handler for mouse entered
func _on_mouse_entered():
	print("slot ", index)

extends Area2D
class_name HandSlot

signal hover(hand_slot: HandSlot)
signal exit(hand_slot: HandSlot)
signal click(hand_slot: HandSlot)

# HandSlot properties for width, height, and index
var width := 100.0
var height := 100.0
var index := 0
var rects = []

var card: Card

func _draw():
	for r in rects: 
		draw_rect(r,Color.AQUA,false,1)
		
# Initialize the slot with dimensions and index
func setup_slot(slot_width: float, slot_height: float, slot_index: int, new_card: Card):
	width = slot_width
	height = slot_height
	index = slot_index
	card = new_card
	
	# Set the collision shape
	# var collision_shape = CollisionShape2D.new()
	# var shape = RectangleShape2D.new()
	$CollisionShape2D.shape.extents = Vector2(width / 2.0, height / 2.0)
	# collision_shape.shape = shape
	# add_child(collision_shape)#
	rects.append($CollisionShape2D.shape.get_rect())
	queue_redraw()

	# Add a label to display the index
	# var label = Label.new()
	$Label.text = str(index)
	$Label.size = Vector2(width, height)
	#label.horizontal_alignment = Label.ALIGN_CENTER
	#label.vertical_alignment = Label.VALIGN_CENTER
	# add_child(label)
	
	# Connect mouse enter and exit signals
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	# Add input handling
	input_event.connect(_on_input_event)
	
	# Show the name of the slot in the scene tree
	name = 'slot_' + str(index)

func select():
	card.select()
	
func deselect():
	card.deselect()
	
func _on_mouse_entered():
	print("hovering ", name)
	hover.emit(self)

func _on_mouse_exited():
	print("exiting ", name)
	exit.emit(self)

func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("clicked ", name)
		click.emit(self)

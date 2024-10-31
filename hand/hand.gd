extends Node2D

var card_count = 8
var cards = range(card_count)
@onready var outline = $Area2D/CollisionShape2D
const HandSlot = preload("res://hand/slot_area.gd") # Adjust the path to the actual location of HandSlot.gd

func _ready():
	_create_slots()

func _create_slots():
	
	const max_width = 75.0  
		
	for c in outline.get_children():
		c.queue_free()
	
	# Get the dimensions of the outline's shape
	var outline_shape = outline.shape
	var outline_width = outline_shape.size.x 
	var outline_height = outline_shape.size.y 
	
	# Calculate each card's width and height
	var card_width = outline_width / card_count
	var corrected_width = card_width
	

	
	var x_offset = 0 
	
	if card_width > max_width:
		var total_width = len(cards) * max_width
		 
		x_offset = (outline_width - total_width) * 0.5
		corrected_width = max_width
		print(x_offset)
		
	var card_height = outline_height
	
	# Create and position each HandSlot instance
	for i in cards:
		# Instantiate the HandSlot node
		var hand_slot_instance = HandSlot.new()
		
		# Set up the hand slot with dimensions and index
		hand_slot_instance.setup_slot(corrected_width, card_height, i)
		
		# Position the hand slot horizontally
		hand_slot_instance.position = Vector2(x_offset  +  i * corrected_width + corrected_width / 2 - outline_width / 2, 0)
		
		# Add the HandSlot instance as a child of the outline
		outline.add_child(hand_slot_instance)	

func _on_area_2d_mouse_entered():
	print("Entered Hand")	 


func _on_area_2d_mouse_exited():
	print("Exited Hand")	


func _on_add_card_pressed():
	card_count += 1
	cards = range(card_count) # Replace with function body.
	_ready()

func _on_remove_card_pressed():
	card_count -= 1
	cards = range(card_count)
	_ready()

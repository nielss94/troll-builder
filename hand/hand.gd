extends Node2D

var card_count = 6
var cards = range(card_count)
@onready var outline = $Area2D/CollisionShape2D
@export var hand_slot_scene: PackedScene
@export var card_scene: PackedScene
@export var spells: Array[Spell] = []

var selected_slot: HandSlot

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
		
		# calculate x_offset to center align slots
		var total_width = len(cards) * max_width	 
		x_offset = (outline_width - total_width) * 0.5
		
		# set used width to max width
		corrected_width = max_width
		
	var card_height = outline_height
	
	# Create and position each HandSlot instance
	for i in cards:
		# Instantiate the HandSlot node
		var hand_slot_instance: HandSlot = hand_slot_scene.instantiate()
		
		# Position the hand slot horizontally
		hand_slot_instance.position = Vector2(x_offset  +  i * corrected_width + corrected_width / 2 - outline_width / 2, 0)

		# Instantiate the card node
		var card_instance = card_scene.instantiate()
		
		# # Initialize the card with a random spell
		var random_spell: Spell = spells[randi() % spells.size()]
		card_instance.init(random_spell)
		
		# Set up the hand slot with dimensions and index
		hand_slot_instance.setup_slot(corrected_width, card_height, cards.find(i), card_instance)

		
		# Add the card to the hand slot
		hand_slot_instance.add_child(card_instance)

		hand_slot_instance.hover.connect(_on_slot_mouse_entered)
		hand_slot_instance.exit.connect(_on_slot_mouse_exited)
		
		
		
		# Add the HandSlot instance as a child of the scene tree root
		outline.add_child(hand_slot_instance)	

func _on_slot_mouse_entered(slot: HandSlot):
	if selected_slot:
		selected_slot.deselect()
		selected_slot.click.disconnect(_on_slot_clicked)
	
	selected_slot = slot
	selected_slot.select()
	selected_slot.click.connect(_on_slot_clicked)
	print("Selected slot: ", selected_slot.name)

func _on_slot_mouse_exited(slot: HandSlot):
	if selected_slot == slot:
		selected_slot.deselect()
		selected_slot.click.disconnect(_on_slot_clicked)
		selected_slot = null

func _on_slot_clicked(slot: HandSlot):
	print("Clicked slot: ", slot.name)

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

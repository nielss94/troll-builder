extends Node2D
class_name Card

@onready var name_label: Label = $Name
@onready var description_label: RichTextLabel = $Description
@onready var card_texture: Sprite2D = $CardImage
@onready var spell_texture: Sprite2D = $SpellImage

@export var spell: Spell
@export var max_rotation_degrees: float = 10.0 # Maximum rotation in either direction
var base_rotation: float = 0.0 # Store the card's initial rotation
var tween: Tween

func _ready():
	if spell:
		name_label.text = spell.name
		description_label.text = _translate_spell_description(spell.description)
		card_texture.texture = spell.card_texture
		spell_texture.texture = spell.spell_texture
	
	base_rotation = rotation_degrees # Store initial rotation
	
	$Area2D.mouse_entered.connect(_on_area_2d_mouse_entered)
	$Area2D.mouse_exited.connect(_on_area_2d_mouse_exited)
	$Area2D.input_event.connect(_on_area_2d_input_event)

func _on_area_2d_mouse_exited():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1)

func _on_area_2d_mouse_entered():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)

func _translate_spell_description(description: String) -> String:
	description = description.replace("{damage_to_self}", "[color=red]" + str(spell.damage_to_self) + "[/color]")
	description = description.replace("{heal}", "[color=green]" + str(spell.heal) + "[/color]")
	description = description.replace("{damage}", "[color=red]" + str(spell.damage) + "[/color]")
	description = description.replace("{heal_to_enemy}", "[color=green]" + str(spell.heal_to_enemy) + "[/color]")
	return description

func _on_area_2d_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Clicked card: ", spell.name)

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	var screen_center_x = get_viewport_rect().size.x / 2
	var card_center = global_position

	# Calculate rotation based on mouse x distance
	var x_diff = mouse_pos.x - card_center.x
	var rotation_factor = clamp(x_diff / 500.0, -1.0, 1.0) # Adjust 500.0 to change distance sensitivity
	var target_rotation = base_rotation - (max_rotation_degrees * rotation_factor)
	rotation_degrees = lerp(rotation_degrees, target_rotation, 0.1) # Adjust 0.1 to change rotation smoothness  

extends Node2D
class_name Card

@export var spell: Spell
@export var max_rotation_degrees: float = 10.0 # Maximum rotation in either direction
var base_rotation: float = 0.0 # Store the card's initial rotation
var tween: Tween
var flip_amount: float = 0.0


func _ready():
	if spell:
		init(spell)
	
	base_rotation = rotation_degrees # Store initial rotation

func init(new_spell: Spell):
	self.spell = new_spell
	$Name.text = new_spell.name
	$Description.text = _translate_spell_description(new_spell.description)
	$CardImage.texture = new_spell.card_texture
	$SpellImage.texture = new_spell.spell_texture

func _translate_spell_description(description: String) -> String:
	description = description.replace("{damage_to_self}", "[color=red]" + str(spell.damage_to_self) + "[/color]")
	description = description.replace("{heal}", "[color=green]" + str(spell.heal) + "[/color]")
	description = description.replace("{damage}", "[color=red]" + str(spell.damage) + "[/color]")
	description = description.replace("{heal_to_enemy}", "[color=green]" + str(spell.heal_to_enemy) + "[/color]")
	return description

func _process(_delta):
	
	# ??????????????????????????????????
	# material.flip_amount = flip_amount
	
	
	var mouse_pos = get_global_mouse_position()
	var screen_center_x = get_viewport_rect().size.x / 2
	var card_center = global_position

	# Calculate rotation based on mouse x distance
	var x_diff = mouse_pos.x - card_center.x
	var rotation_factor = clamp(x_diff / 500.0, -1.0, 1.0) # Adjust 500.0 to change distance sensitivity
	var target_rotation = base_rotation - (max_rotation_degrees * rotation_factor)
	rotation_degrees = lerp(rotation_degrees, target_rotation, 0.1) # Adjust 0.1 to change rotation smoothness  

func select():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
	
func deselect():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1)

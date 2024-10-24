extends Node2D


func set_char_pos(new_pos):
	var character = get_node("CharacterBody2D")
	if character:
		character.position = new_pos
	
func _ready():
	set_char_pos(Vector2(95, 287))
	
func _process(delta):
	var character = get_node("CharacterBody2D")
	if character.position.y >= 300:
		set_char_pos(Vector2(95, 287))
		print("FELL")

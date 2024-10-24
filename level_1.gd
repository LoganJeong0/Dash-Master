extends Node2D



func _on_area_2d_body_entered(body):
	get_tree().change_scene_to_file("res://level_2.tscn")

func set_char_pos(new_pos):
	var character = get_node("CharacterBody2D")
	if character:
		character.position = new_pos
	
func _ready():
	set_char_pos(Vector2(37, 480))
	
func _process(delta):
	var character = get_node("CharacterBody2D")
	if character.position.y >= 900:
		set_char_pos(Vector2(37, 480))
		print("FELL")

extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var cooldown_up = false
var moving = false
var target_position = Vector2(0, 0)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var saved_location = position

#func _ready():
	#$cooldown_timer.start()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		get_node("AnimationPlayer").play("Run")
		if velocity.x < 0:
			get_node("AnimatedSprite2D").flip_h = true
			get_node("AnimationPlayer").play("Run")
		else:
			get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimationPlayer").play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


var speed = 30000

#func _input(event):		
	#if event is InputEventMouseButton:
		#target_position = get_global_mouse_position()
		#print(target_position)

		
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not moving and not cooldown_up:
		var mouse_pos_viewport = get_viewport().get_mouse_position()
		var root_viewport = get_tree().root
		var global_transform = root_viewport.get_canvas_transform()
		target_position = global_transform.basis_xform_inv(mouse_pos_viewport)
		
		#print(target_position1)
		#var target_position2 = to_global(target_position1)
		#print(target_position2)
		moving = true
		cooldown_up = true
		$cooldown_timer.start()

	if moving:
		position = position.move_toward(target_position, speed * delta)
		
		# Check if the character has reached the target position
		if position.distance_to(target_position) < 1:  # Use a small threshold to avoid floating point precision issues
			position = target_position
			moving = false
			


func _on_cooldown_timer_timeout():
	cooldown_up = false
	print("Ready!")

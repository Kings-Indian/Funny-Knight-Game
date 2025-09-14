extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0  # Doubled jump strength

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump with multiple keys
	if (Input.is_action_just_pressed("ui_accept") 
		or Input.is_action_just_pressed("ui_up") 
		or Input.is_action_just_pressed("jump")
		or Input.is_action_just_pressed("move_up")) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle horizontal movement with WASD and arrow keys
	var direction := 0.0
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("move_left"):
		direction -= 1.0
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("move_right"):
		direction += 1.0

	if direction != 0.0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

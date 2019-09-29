extends Camera2D

export(float) var movementSpeed = 10.0

func _ready():
	pass

func _physics_process(delta):
	var cameraRightAxis = Input.get_action_strength("camera_right") - Input.get_action_strength("camera_left")
	var cameraDownAxis = Input.get_action_strength("camera_down") - Input.get_action_strength("camera_up")
	var movementDirection = Vector2(cameraRightAxis, cameraDownAxis)
	
	#if(abs(get_local_mouse_position().x) > get_viewport().size.x / 2 * 0.7 || abs(get_local_mouse_position().y) > get_viewport().size.y / 2 * 0.7):
	#	movementDirection = Vector2(sign(floor(get_local_mouse_position().x * 0.05)), sign(floor(get_local_mouse_position().y)))  
	
	self.position += movementDirection * movementSpeed * delta
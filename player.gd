extends CharacterBody2D

var movespeed = 500
var bullet_speed = 800
var bullet = preload("res://bullet.tscn")

func _physics_process(delta):
	var motion = Vector2()
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("right"):
		motion.x += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	
	motion = motion.normalized() * movespeed
	
	velocity = motion  
	move_and_slide()  

	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("LMB"):
		fire()

func fire():
	var bullet_instance = bullet.instantiate() # Use instantiate() instead of instance()
	bullet_instance.position = global_position
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.linear_velocity = Vector2(bullet_speed, 0).rotated(rotation)
	get_tree().root.call_deferred("add_child", bullet_instance) # Ensure it's added safely

	
	

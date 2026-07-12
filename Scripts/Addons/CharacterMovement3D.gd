extends CharacterBody3D

# キャラの座標移動を実装
class_name CharacterMovement3D

@export var MoveSpeed: float = 5.0
@export var JumpVelocity: float = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var _inputHanlder := $"InputHandler" as InputHandler

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	if not get_node_or_null("InputHandler"):
		warnings.append("子ノードにInputHandlerを追加してください")

	return warnings
# << _get_configuration_warnings

func _ready() -> void:
	# 取得に失敗した場合にはearly-return
	if !_inputHanlder:
		return
		
	_inputHanlder.OnJump.connect( _onJumpFired )
# << _ready

func _onJumpFired():
	# Handle Jump.
	velocity.y = JumpVelocity
# << _onJumpFired

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta * MoveSpeed
		
	# 入力ハンドラーあるか判定
	if _inputHanlder:
		var input_dir := _inputHanlder.MoveInput
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * MoveSpeed
			velocity.z = direction.z * MoveSpeed
		else:
			velocity.x = move_toward(velocity.x, 0, MoveSpeed)
			velocity.z = move_toward(velocity.z, 0, MoveSpeed)

	move_and_slide()
# << _physics_process

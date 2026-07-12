extends Node

class_name InputHandler

# ジャンプイベント
signal OnJump;

## 移動入力
@export var MoveInput: Vector2
## 視点入力
@export var ViewInput: Vector2
## デバッグコンソールに出力するか
@export var PrintToConsole: bool

func _ready() -> void:
	pass # Replace with function body.
# << _ready

func _process(delta: float) -> void:
	# 移動入力
	MoveInput = Input.get_vector("MoveLeft" , "MoveRight" , "MoveUp" , "MoveDown")
	MoveInput = MoveInput.normalized()
	if PrintToConsole:
		print( "MoveInput:" , MoveInput )
# << _process

func _input(event: InputEvent) -> void:
	# マウスイベントの取得
	if event is InputEventMouseMotion:
		var delta: Vector2 = event.relative
		ViewInput = delta
		if PrintToConsole:
			print( "ViewInput" , ViewInput )
	# << マウスイベント
			
	# ジャンプ入力
	if event is InputEventKey:
		var isJump: bool = event.is_action_pressed("Jump")
		if isJump:
			OnJump.emit()
	# << ジャンプ入力
# << _input
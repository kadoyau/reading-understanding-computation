# 和と積の演算
expression =
Add.new(
	Multiply.new(Number.new(1), Number.new(2)),
	Multiply.new(Number.new(3), Number.new(4))
)

# ブール式
Machine.new(
	LessThan.new(Number.new(5), Add.new(Number.new(2), Number.new(2)))
).run

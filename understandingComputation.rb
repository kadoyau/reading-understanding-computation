class Number < Struct.new(:value)
end
class Add < Struct.new(:left, :right)
end
class Multiply < Struct.new(:left, :right)
end
Add.new(Multiply.new(Number.new(1), Number.new(2)),
Multiply.new(Number.new(3), Number.new(4)))

class Number
	def to_s
		value.to_s
	end
	def inspect
		"<<#{self}>>"
	end
end

class Add
	def to_s
		"#{left} + #{right}"
	end
	def inspect
		"<<#{self}>>"
	end
end

class Multiply
	def to_s
		"#{left} * #{right}"
	end
	def inspect
		"<<#{self}>>"
	end
end

class Number
	def reducible?
		false
	end
end
class Add
	def reducible?
		true
	end
end
class Multiply
	def reducible?
		true
	end
end

# 簡約する
class Add
	def reduce
		if left.reducible?
			Add.new(left.reduce, right)
		elsif right.reducible?
			Add.new(left, right.reduce)
		else
			Number.new(left.value + right.value)
		end
	end
end


class Multiply
	def reduce
		if left.reducible?
			Multiply.new(left.reduce, right)
		elsif right.reducible?
			Multiply.new(left, right.reduce)
		else
			Number.new(left.value * right.value)
		end
	end
end

expression =
Add.new(
	Multiply.new(Number.new(1), Number.new(2)),
	Multiply.new(Number.new(3), Number.new(4))
)

# 抽象機械
class Machine < Struct.new(:expression)
	def step
		self.expression = expression.reduce
	end
	def run
		while expression.reducible?
			puts expression.inspect
			step
		end
		puts expression.inspect
	end
end
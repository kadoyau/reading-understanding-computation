# 2.3.1.1 式
class Number < Struct.new(:value)
end
class Add < Struct.new(:left, :right)
end
class Multiply < Struct.new(:left, :right)
end
Add.new(Multiply.new(Number.new(1), Number.new(2)), Multiply.new(Number.new(3), Number.new(4)))

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

class Boolean < Struct.new(:value)
	def to_s
		value.to_s
	end

	def inspect
		"<<#{self}>>"
	end

	def reducible?
		false
	end
end

class LessThan < Struct.new(:left, :right)
	def to_s
		"#{left} < #{right}"
	end

	def inspect
		"#{self}"
	end

	def reducible?
		true
	end

	def reduce
		if left.reducible?
			LessThan.new(left.reduce, right)
		elsif right.reducible?
			LessThan.new(left, right.reduce)
		else
			# trueかfalseかの表示はrubyの < 演算子の結果に任せる
			Boolean.new(left.value < right.value)
		end
	end
end

# p.29 変数を導入する
class Variable < Struct.new(:name)
  def to_s
    name.to_s
  end

  def inspect
    "#{self}"
  end

  def reducible?
    true
  end
end

class Variable
  def reduce(environment)
    environment[name]
  end
end

class Add
	def reduce(environment)
		if left.reducible?
			Add.new(left.reduce(environment), right)
		elsif right.reducible?
			Add.new(left, right.reduce(environment))
		else
			Number.new(left.value + right.value)
		end
	end
end

class Multiply
	def reduce(environment)
		if left.reducible?
			Multiply.new(left.reduce(environment), right)
		elsif right.reducible?
			Multiply.new(left, right.reduce(environment))
		else
			Number.new(left.value * right.value)
		end
	end
end

class LessThan
	def reduce(environment)
		if left.reducible?
			LessThan.new(left.reduce(environment), right)
		elsif right.reducible?
			LessThan.new(left, right.reduce(environment))
		else
			Boolean.new(left.value < right.value)
		end
	end
end

Object.send(:remove_const, :Machine) #過去のMachineを消す
class Machine < Struct.new(:expression, :environment)
	def step
		self.expression = expression.reduce(environment)
	end
	def run
		while expression.reducible?
			puts expression.inspect
			step
		end
		puts expression.inspect
	end
end

# 2.3.1.2 文
class DoNothing
	def to_s
		'do-nothing'
	end

	def inspect
		"#{self}"
	end

	def ==(other_statement)
		other_statement.instance_of?(DoNothing)
	end

	def reducible?
		false
	end
end

class Assign < Struct.new(:name, :expression)
	def to_s
		"#{name} = #{expression}"
	end

	def inspect
		"#{self}"
	end

	def reducible?
		true
	end

	def reduce(environment)
		if expression.reducible?
			[Assign.new(name, expression.reduce(environment)), environment]
		else
			[DoNothing.new, environment.merge({ name => expression })]
		end
	end
end

Object.send(:remove_const, :Machine) #過去のMachineを消す
class Machine < Struct.new(:statement, :environment)
	def step
		self.statement, self.environment = statement.reduce(environment)
	end

	def run
		while statement.reducible?
			puts "#{statement}, #{environment}"
			step
		end
		puts "#{statement}, #{environment}"
	end
end

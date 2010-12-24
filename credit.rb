class Credit

	attr_accessor :creditor, :amount

	def initialize person, amount
		@creditor = person
		@amount = amount
	end

end

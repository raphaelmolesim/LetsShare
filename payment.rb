class Payment
	
	attr_accessor :debtor, :amount
	
	def initialize person, amount
		@debtor = person
		@amount = amount
	end
	
end

class Payment
	
	attr_accessor :debtor, :creditor, :amount
	
	def initialize debtor, creditor, amount
		@debtor = debtor
		@creditor = creditor
		@amount = amount
	end
	
end

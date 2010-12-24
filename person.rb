class Person
	attr_accessor :name

	def initialize name
		@name = name
		@payed_bills = []
	end
	
	def payed bill
		@payed_bills << bill
	end
	
	def total_spent
		@payed_bills.inject(0){|sum, bill| sum + bill.amount}
	end
end

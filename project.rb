class Project
	
	attr_accessor :name, :refunds, :payments

	def initialize name
		@name = name
		@participants = []
		@refunds = []
		@payments = []
	end
	
	def add_participant person
		@participants << person
		calculate_refunds
		calculate_payments
	end
	
	def number_of_participants
		@participants.size
	end
	
	def calculate_refunds
		@refunds = []
		creditors = @participants.find_all { |participant| participant.total_spent > 0 }
		creditors.each do |creditor|
			amount = calculate_amount(creditor)
			@refunds << Refund.new(creditor, amount) if amount > 0
		end
	end
	
	def calculate_payments
		@payments = []
		debtors = @participants - @refunds.collect { |refund| refund.creditor }
		debtors.each do |debtor|
			amount = media - debtor.total_spent
			@payments << Payment.new(debtor, amount) if amount > 0
		end
	end
	
	def calculate_amount creditor
		amount = creditor.total_spent - media
		return 0 if (amount < 0)
		amount
	end
	
	def media
		total_spent / @participants.size
	end
	
	def total_spent
		@participants.inject(0){ |sum, participant| sum + participant.total_spent }
	end
	
end

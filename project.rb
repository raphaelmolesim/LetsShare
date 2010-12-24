class Project
	
	attr_accessor :name, :credits, :debts

	def initialize name
		@name = name
		@participants = []
		@credits = []
		@debts = []
	end
	
	def add_participant person
		@participants << person
		calculate_credits
		calculate_debts
	end
	
	def number_of_participants
		@participants.size
	end
	
	def calculate_credits
		@credits = []
		creditors = @participants.find_all { |participant| participant.total_spent > 0 }
		creditors.each do |creditor|
			amount = calculate_amount(creditor)
			@credits << Payment.new(creditor, amount) if amount > 0
		end
	end
	
	def calculate_debts
		@debts = []
		debtors = @participants - @credits.collect { |credit| credit.person }
		debtors.each do |debtor|
			amount = media - debtor.total_spent
			@debts << Payment.new(debtor, amount) if amount > 0
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

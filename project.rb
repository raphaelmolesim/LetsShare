class Project
	
	attr_accessor :name, :credits, :debts

	def initialize name
		@name = name
		@participants = []
		@credits = []
		@debts = []
		@payments = []
	end
	
	def add_participant person
		@participants << person
		generate_balance
	end
	
	def do_payment debtor, creditor, amount
		@payments << Payment.new(debtor, creditor, amount)
		generate_balance
	end
	
	def number_of_participants
		@participants.size
	end
	
	def total_spent
		@participants.inject(0){ |sum, participant| sum + participant.total_spent }
	end
	
	def media
		total_spent / @participants.size
	end
	
	private
		
		def generate_balance
			calculate_credits
			calculate_debts
		end
		
		def calculate_credits
			@credits = []
			creditors = @participants.find_all { |participant| participant.total_spent > 0 }
			creditors.each do |creditor|
				amount = calculate_amount(creditor)
				@credits << Credit.new(creditor, amount) if amount > 0
			end
		end
	
		def calculate_debts
			@debts = []
			debtors = @participants - @credits.collect { |credit| credit.creditor }
			debtors.each do |debtor|
				debtor_payments = @payments.find_all { |payment| payment.debtor == debtor }
				total_payed = debtor_payments.inject(0) { |sum, payment| sum + payment.amount }
				amount = media - debtor.total_spent - total_payed
				@debts << Debt.new(debtor, amount) if amount > 0
			end
		end
	
		def calculate_amount creditor
			amount = creditor.total_spent - media
			creditor_payments = @payments.find_all { |payment| payment.creditor == creditor }
			total_payed = creditor_payments.inject(0) { |sum, payment| sum + payment.amount }
			amount = amount - total_payed
			return 0 if (amount < 0)
			amount
		end
		
end

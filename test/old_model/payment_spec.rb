require "person"
require "payment"

describe Payment do
	
	it "could have a debtor, creditor and a amount" do
		payment = Payment.new(Person.new("Raphael"), Person.new("Victor"), 12.48)
		payment.debtor.name.should be == "Raphael"
		payment.creditor.name.should be == "Victor"
		payment.amount.should be == 12.48
	end
	
end

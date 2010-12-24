require "person"
require "payment"

describe Payment do

	before do
		@payment = Payment.new(Person.new("Raphael"), 12.48)
	end
	
	it "should have a debtor and a amount" do
		@payment.debtor.name.should be == "Raphael"
		@payment.amount.should be == 12.48
	end
	
end

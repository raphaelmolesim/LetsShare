require "person"
require "refund"

describe Refund do

	before do
		@refund = Refund.new(Person.new("Raphael"), 12.48)
	end
	
	it "should have a creditor and a amount" do
		@refund.creditor.name.should be == "Raphael"
		@refund.amount.should be == 12.48
	end
	
end

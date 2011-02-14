require "person"
require "credit"

describe Credit do

	before do
		@credit = Credit.new(Person.new("Raphael"), 12.48)
	end

	it "should have a creditor and a amount" do
		@credit.creditor.name.should be == "Raphael"
		@credit.amount.should be == 12.48
	end

end

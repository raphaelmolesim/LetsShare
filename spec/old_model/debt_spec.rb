require "person"
require "debt"

describe Debt do

	before do
		@debt = Debt.new(Person.new("Raphael"), 12.48)
	end

	it "should have a debtor and a amount" do
		@debt.debtor.name.should be == "Raphael"
		@debt.amount.should be == 12.48
	end

end

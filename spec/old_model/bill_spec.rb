require "bill"

describe Bill do

	before do
		@bill = Bill.new(1.00)
	end
	it "should have a amount" do
		@bill.amount.should be == 1.00
	end
	
end

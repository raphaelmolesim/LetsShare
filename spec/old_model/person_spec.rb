require "person"
require "bill"

describe Person do

	before do
		@person = Person.new("Raphael")
	end
	it "should have a name" do
		@person.name.should be == "Raphael"
	end
	
	it "should be able to have one bill" do
		bill = Bill.new 5.20
		@person.payed bill
		@person.total_spent.should be == 5.20
	end
	
	it "should be able to have two bills" do
		[Bill.new(5.20), Bill.new(7.63)].each {|bill| @person.payed bill }
		@person.total_spent.should be == 12.83
	end
end

require "person"
require "project"
require "refund"
require "bill"
require "payment"

describe Project do

	before do
		@project = Project.new("Raphael")
	end
	
	it "should have a name" do
		@project.name.should be == "Raphael"
	end
	
	it "should have participant" do
		[Person.new("Raphael"), 
		 Person.new("Victor")].each {|person| @project.add_participant person }
		@project.number_of_participants.should be == 2
	end
	
	it "should say how much each creditor should be refund" do
		participants = [Person.new("Raphael"), Person.new("Victor"), Person.new("Stephanie"), 
										Person.new("Tati"), Person.new("Alex")]
		participants[0].payed Bill.new 10.71
		participants[1].payed Bill.new 5.48
		participants[2].payed Bill.new 2.19
		participants.each {|person| @project.add_participant person }
		media = (10.71 + 5.48 + 2.19) / 5
		
		@project.refunds.size.should be == 2		
		@project.refunds[0].creditor.should be == participants[0]
		@project.refunds[0].amount.should be == 10.71 - media
		@project.refunds[1].creditor.should be == participants[1]
		@project.refunds[1].amount.should be == 5.48 - media
	end
	
	it "should say how much each debtor should pay" do 
		participants = [Person.new("Raphael"), Person.new("Victor"), Person.new("Stephanie"), 
										Person.new("Tati"), Person.new("Alex")]
		participants[0].payed Bill.new 10.71
		participants[1].payed Bill.new 5.48
		participants[2].payed Bill.new 2.19
		participants.each {|person| @project.add_participant person }
		media = (10.71 + 5.48 + 2.19) / 5
		
		@project.payments.size.should be == 3
		@project.payments[0].debtor.should be == participants[2]
		@project.payments[0].amount.should be == media - participants[2].total_spent
		@project.payments[1].debtor.should be == participants[3]
		@project.payments[1].amount.should be == media
		@project.payments[2].debtor.should be == participants[4]
		@project.payments[2].amount.should be == media
	end
	
end

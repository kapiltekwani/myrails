require 'faker'
namespace :admin do
  desc "to create dummy order records in development mode"
  task :generate => :environment do
    [Customer, Order].each(&:destroy_all)

    10.times do 
      @customer = Customer.create(:name => "#{Faker::Name.name}", :email => "#{Faker::Internet.email}");
      10000.times do
        @order = Order.create(:order_date => "#{Array(Date.new(2011,1,1)..Date.today).sample}", :status => "paid", :price => "#{rand(100)}", :customer_id => @customer._id)
        @order.items.create(:sku => "abc", :qty => "#{rand(10)}")
        @order.items.create(:sku => "def", :qty => "#{rand(10)}")
        @order.items.create(:sku => "ghi", :qty => "#{rand(10)}")
      end
    end
  end
end

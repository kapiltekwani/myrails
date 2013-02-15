class Order
  include Mongoid::Document
  field :order_date, type: Date
  field :status, type: String
  field :price, type: Integer
  
  belongs_to :customer
  embeds_many :items
  has_and_belongs_to_many :tags, :inverse_of => nil

  def self.calculate_price
    map = %Q{
      function(){
        emit(this.customer_id, this.price);
      }
    }

    reduce = %Q{
      function(key,values){
        return Array.sum(values);
      }
    }

    result = Order.map_reduce(map,reduce).out(replace: "totalprice")
  end

  def self.calculate_regular
    result_hash = {}
    Order.all.each do |order|
      if result_hash[order.customer_id].nil?
        result_hash[order.customer_id] = order.price
      else
        result_hash[order.customer_id] += order.price
      end
    end
    result_hash
  end
  
  def self.calculate_average
    map = %Q{
      function(){
        for(var id in this.items){
          key = this.items[id].sku;
          value = {count:1, qty: this.items[id].qty};
          emit(key,value);
        }
      }
    }

    reduce = %Q{
      function(key,values){
        reducedValue = {count:0, qty: 0, average:0};
        for(var id = 0; id < values.length; id++){
          reducedValue.count += values[id].count;
          reducedValue.qty += values[id].qty;

        }
        return reducedValue;
      }
    }

    final_func = %Q{
      function(key, reducedValue){
        reducedValue.average = reducedValue.qty/reducedValue.count;
        return reducedValue;
      }
    }
    result = Order.map_reduce(map,reduce).out(replace: "avergare").finalize(final_func)
  end

  def self.average_regular
    result_hash = {}
    Order.all.each do |order|
      order.items.each do |item|
        if !result_hash.has_key?(item.sku)
          result_hash.merge!(item.sku => {:qty => item.qty, :count => 1})
        else
          result_hash[item.sku][:qty] += item.qty;
          result_hash[item.sku][:count] += 1;
        end
      end
    end
    result_hash.each do |key,value|
      result_hash[key][:average] = (result_hash[key][:qty].to_f)/result_hash[key][:count]
    end
    result_hash
  end
end

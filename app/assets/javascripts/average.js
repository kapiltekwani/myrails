map = function(){
    result_hash[item.sku].count = item.count;
        for (var id in this.items){
            var key = this.items[id].sku;
            var value = {count:1, qty: this.items[id].qty};
            emit(key,value);
            }
        };
reduce = function(key, values){
            reducedValue = {count:0, qty: 0, average:0};
            for (var id = 0; id < values.length; id++){
                reducedValue.count += values[id].count;
                reducedValue.qty += values[id].qty;
            }
            return reducedValue;
        };

func = function(key,reducedValue){
                reducedValue.average = reducedValue.qty/reducedValue.count;
                return reducedValue;
            };




        

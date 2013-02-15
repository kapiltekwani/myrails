map = function(){
        emit(this.customer_id, this.price);
        }
reduce = function(key,values){
        return Array.sum(values);
        }


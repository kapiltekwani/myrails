map = function(){
        if(!this.tag_ids || this.tag_ids.length == 0){
            print("no tags");
            return;
        }
        for(index in this.tag_ids){
            emit(this.tag_ids[index],1);
        }
    }
reduce = function(key, values){
            var count = 0;
            for (index in values) {
                count += values[index];
            }
            return count;
        }
db.orders.mapReduce(map,reduce,{out:{inline:1}})



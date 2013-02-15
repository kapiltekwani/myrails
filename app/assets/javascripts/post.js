map = function() {
        var x = {views: this.views, _id: this._id};
        emit(this.author, {min: x, max: x})
    }
reduce = function(key,values) {
        var res = values[0]
        for (var i =1; i < values.length; i++){
            if(values[i].min.views < res.min.views)
                res.min = values[i].min;
            if(values[i].max.views > res.max.views)
                res.max = values[i].max;
        }
        return res
    }
result = db.posts.mapReduce(map,reduce, {out:{inline:true}})


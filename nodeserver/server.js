var io = require('socket.io').listen(5001),
    redis = require('redis').createClient();

redis.subscribe('rt-change');


var clients = {};

io.on('connection', function(socket){
    console.log('Client ', socket.id, ' logged in.');

    socket.on('storeUserId', function(data){
        clients[data.id] = socket.id;
        clients[socket.id] = data.id;

        // Subsribe to user specific notification channel
        redis.subscribe('notify' + data.id)
        console.log(clients)
    })
    socket.on('disconnect', function(){
        // Unsub to user specific notification channel
        redis.unsubscribe('notify' + clients[socket.id]);
        console.log('Client ', socket.id, ' logged out.');
        delete clients[clients[socket.id]];
        delete clients[socket.id];
        console.log(clients)
    });

});
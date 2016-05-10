var io = require('socket.io').listen(5001),
    redis = require('redis').createClient();

var clients = {};

io.on('connection', function(socket){
    //console.log('Client ', socket.id, ' logged in.');
    var subFriendships = require('redis').createClient();
    var subMessaging = require('redis').createClient();

    socket.on('storeUserId', function(data){
        clients[data.id] = socket.id;
        clients[socket.id] = data.id;
        subFriendships.subscribe('notify' + data.id);
        subMessaging.subscribe('messaging' + data.id);
        //console.log(clients)
    });

    socket.on('disconnect', function(){
        subFriendships.unsubscribe('notify' + clients[socket.id]);
        //console.log('Client ', socket.id, ' logged out.');
        delete clients[clients[socket.id]];
        delete clients[socket.id];
        //console.log(clients)
    });

    subFriendships.on('message', function(channel, message){
        data = JSON.parse(message);
        socket.emit('friendRequest', JSON.parse(message));
        //console.log(message)
    });

    subMessaging.on('message', function(channel, message){
        data = JSON.parse(message);
        socket.emit('messaging', JSON.parse(message));
        //console.log(message)
    })

});
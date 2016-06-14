var redis = require('redis').createClient();

var fs = require('fs');

var options = {
    key: fs.readFileSync('./server.key'),
    cert: fs.readFileSync('./server.crt')
};

var app = require('https').createServer(options)
    , io = require('socket.io').listen(app);

app.listen(5001);

var clients = {};

io.on('connection', function(socket){
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

    socket.on('connectionCheck', function(data){
        socket.emit(clients[data.id] != null);
    });

    socket.on('initCall', function(data){
        io.sockets.connected[clients[data.id]].emit('calling', data);
    });

    socket.on('endCall', function(data){
        io.sockets.connected[clients[data.id]].emit('peerEndCall', data);
    });

    socket.on('answerCall', function(data){
        io.sockets.connected[clients[data.id]].emit('answering', data);
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
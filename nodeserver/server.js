var io = require('socket.io').listen(5001),
    redis = require('redis').createClient();

redis.subscribe('rt-change');

io.on('connection', function(socket){
    console.log('Un client est connecté !');
    redis.on('message', function(channel, message){
        socket.emit('rt-change', JSON.parse(message));
    });

    socket.emit('message', {content: 'Vous etes bien connecté !'})
});
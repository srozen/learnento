var io = require('socket.io').listen(5001),
    redis = require('redis').createClient();

redis.subscribe('rt-change');

io.on('connection', function(socket){
    console.log('Un client est connecté !');
    redis.on('message', function(channel, message){
        socket.emit('rt-change', JSON.parse(message));
    });
    socket.on('disconnect', function(){
        console.log('Un client est déconnecté ! ');
    });

    socket.emit('message', {content: 'Vous etes bien connecté !'})
    socket.broadcast.emit('message', {content: 'Un autre client vient de se connecter ! '});
});
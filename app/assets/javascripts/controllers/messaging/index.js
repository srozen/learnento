angular.module('Learnento').controller('MessagingIndexController', ['$scope', 'Authentication', '$location', '$document', 'Messaging', 'User', '$rootScope', 'Notification', function($scope, Authentication, $location, $document, Messaging, User, $rootScope, Notification){

    if(!Authentication.loggedIn()){
        $location.path('home');
    }

    $scope.currentUser = Authentication.currentUser();
    User.show($scope.currentUser.id).success(function(data){
        $scope.currentUser['details'] = data;
    });


    navigator.getUserMedia = ( navigator.getUserMedia ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia ||
    navigator.msGetUserMedia);

    var peer;
    var interlocutorId;
    var localVideo = document.getElementById('own-video');
    var peerVideo = document.getElementById('peer-video');
    var localStream, peerStream;

    $scope.initCall = function(id){
        navigator.getUserMedia({video: true, audio: true}, function(stream){

            interlocutorId = id;

            $scope.$apply(function(){
                $scope.videoChatting = true;
            });

            localStream = stream;
            localVideo.srcObject = stream;

            peer = new window.SimplePeer({
                initiator: true,
                trickle: true,
                stream: stream
            });

            var executed = false;
            peer.on('signal', function(data){
                if(!executed){
                    $rootScope.socket.emit('initCall', {id: id, callerId: $scope.currentUser.id, rtcId: JSON.stringify(data)});
                    executed = true;
                }

            });

            $rootScope.socket.on('answering', function(data){
                console.log('receivre response');
                peer.signal(data.rtcId);
            });

            peer.on('stream', function(stream){
                peerVideo.srcObject = stream;
                peerStream = stream;
            })

        }, function(err){
            console.log(err)
        });
    };

    $rootScope.socket.on('calling', function(data){
        console.log('you are called');
        navigator.getUserMedia({video: true, audio: true}, function(stream) {

            interlocutorId = data.callerId;

            $scope.$apply(function(){
                $scope.videoChatting = true;
            });

            localStream = stream;
            localVideo.srcObject = stream;

            peer = new window.SimplePeer({trickle: true, stream: stream});
            var executed = false;
            peer.signal(data.rtcId);
            peer.on('signal', function (signalData) {
                if (!executed) {
                    $rootScope.socket.emit('answerCall', {id: data.callerId, rtcId: JSON.stringify(signalData)});
                    executed = true;
                }
            });

            peer.on('stream', function(stream){
                peerVideo.srcObject = stream;
                peerStream = stream;
            });

        }, function(err){
            console.log(err);
        });
    });

    $scope.stopCall = function(){
        localStream.stop();
        localStream = null;
        $scope.videoChatting = false;
        $rootScope.socket.emit('endCall', {id: interlocutorId});
        peer.destroy();
        peer = null;
    };

    $rootScope.socket.on('peerEndCall', function(data){
        localStream.stop();
        localStream = null;
        $scope.$apply(function(){
            $scope.videoChatting = false;
        });
        peer.destroy();
        peer = null;
    });


    // Fetch all the conversations and associated components
    Messaging.all().success(function(data){
        // Fetch the conversations
        $scope.conversations = data.conversations;
        // Fetch the associated friend, lastMessage and newMessage
        angular.forEach($scope.conversations, function(conversation){
            // associated friend
            User.show(getFriendId(conversation, $scope.currentUser.id)).success(function(data){
                conversation['friend'] = data;
            });
            // last message
            Messaging.show(conversation.id).success(function(data){
                conversation['lastMessage'] = data.messages[data.messages.length - 1];
                if(conversation['lastMessage'] != null){
                    User.show(conversation['lastMessage'].user_id).success(function(data){
                        conversation['lastUser'] = data.first_name;
                    })
                }
            });
            // new message notification
            Notification.activeConversationNotification(conversation.id).success(function(data){
                conversation['newMessage'] = data.status;
            })

        });

        $scope.userHasConversations = ($scope.conversations.length != 0);
        if($scope.userHasConversations){

            $scope.activeConversation = $scope.conversations['0'];

            Messaging.show($scope.activeConversation.id).success(function(data){
                $scope.activeMessages = data.messages;
            });

            Notification.clearConversationNotification($scope.activeConversation.id).success(function(data){
                $scope.activeConversation['newMessage'] = data.status;
            })

        }

    });


    // New message handling
    $rootScope.socket.on('messaging', function(data){
        if($scope.activeConversation.id == data.message.conversation_id){
            $scope.activeMessages.push(data.message);
        }
        angular.forEach($scope.conversations, function(conversation){
            if(conversation.id == data.message.conversation_id){
                conversation['lastMessage'] = data.message;
                User.show(data.message.user_id).success(function(data){
                    conversation['lastUser'] = data.first_name;
                });
                if($scope.activeConversation.id != data.message.conversation_id){
                    conversation['newMessage'] = true;
                } else {
                    Notification.clearConversationNotification($scope.activeConversation.id).success(function(data){
                        $scope.activeConversation['newMessage'] = data.status;
                    })
                }
            }
        });
    });

    // Switching conversation
    $scope.switchConversation = function(index){
        $scope.activeConversation = $scope.conversations[index];
        Messaging.show($scope.activeConversation.id).success(function(data){
            $scope.activeMessages = data.messages;
        });
        Notification.clearConversationNotification($scope.activeConversation.id).success(function(data){
            $scope.activeConversation['newMessage'] = data.status;
        })
    };

    var getFriendId = function(conv, currentUserId){
        if(conv.sender_id == currentUserId){
            return conv.recipient_id;
        } else {
            return conv.sender_id
        }
    };

    $scope.sendMessage = function(){
        var data = {
            'data':{
                'type': 'message',
                'attributes': {
                    'user_id': $scope.currentUser.id,
                    'recipientId': $scope.activeConversation.friend.id,
                    'content': $scope.message
                }
            }
        };

        var msg = data.data.attributes;

        $scope.activeMessages.push(msg);

        angular.forEach($scope.conversations, function(conversation){
            if(conversation.id == $scope.activeConversation.id){
                conversation['lastMessage'] = msg;
                User.show($scope.currentUser.id).success(function(data){
                    conversation['lastUser'] = data.first_name;
                })
            }
        });

        Messaging.create(data).success(function(data){
            $scope.message = '';
        })

    };

    $scope.messageClass = function(id){
        if($scope.currentUser.id == id){
            return 'message-current';
        } else {
            return 'message-other';
        }
    }

}]);
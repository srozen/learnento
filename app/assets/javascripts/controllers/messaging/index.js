angular.module('Learnento').controller('MessagingIndexController', ['$scope', 'Authentication', '$location', '$document', 'Messaging', 'User', '$rootScope', 'Notification', function($scope, Authentication, $location, $document, Messaging, User, $rootScope, Notification){

    if(!Authentication.loggedIn()){
        $location.path('home');
    }

    $scope.currentUser = Authentication.currentUser();
    User.show($scope.currentUser.id).success(function(data){
        $scope.currentUser['details'] = data;
    });

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
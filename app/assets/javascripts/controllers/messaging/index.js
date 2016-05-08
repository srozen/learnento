angular.module('Learnento').controller('MessagingIndexController', ['$scope', 'Authentication', '$location', '$document', 'Messaging', 'User', '$rootScope', function($scope, Authentication, $location, $document, Messaging, User, $rootScope){

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
        // Fetch the associated friend
        angular.forEach($scope.conversations, function(conversation){
            User.show(getFriendId(conversation, $scope.currentUser.id)).success(function(data){
                conversation['friend'] = data;
            })
        });
        $scope.activeConversation = $scope.conversations['0'];

        Messaging.show($scope.activeConversation.id).success(function(data){
            $scope.activeMessages = data.messages;
        })
    });

    $rootScope.socket.on('messaging', function(data){
        if($scope.activeConversation.id == data.message.conversation_id){
            $scope.activeMessages.push(data.message);
        }
    });

    $scope.switchConversation = function(index){
            $scope.activeConversation = $scope.conversations[index];
            Messaging.show($scope.activeConversation.id).success(function(data){
                $scope.activeMessages = data.messages;
            });
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

        Messaging.create(data).success(function(data){
            $scope.message = '';
        })

    }

}]);
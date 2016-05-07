angular.module('Learnento').controller('MessagingIndexController', ['$scope', 'Authentication', '$location', '$document', 'Messaging', 'User', function($scope, Authentication, $location, $document, Messaging, User){

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
                    'senderId': $scope.currentUser.id,
                    'recipientId': $scope.activeConversation.friend.id,
                    'message': $scope.message
                }
            }
        };

        Messaging.create(data).success(function(data){
            $scope.message = '';
        })
    }

}]);
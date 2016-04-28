angular.module('Learnento').controller('UsersShowController', ['$stateParams', 'User', '$location', '$scope', 'Authentication', 'PendingFriend', 'Friend', 'FriendRequest',  function($stateParams, User, $location, $scope, Authentication, PendingFriend, Friend, FriendRequest) {
    if(!Authentication.loggedIn()){
        $location.path('home');
    }

    User.show($stateParams.id).then(function(response){
        $scope.user = response.data;
        $scope.editButton = Authentication.isOwner($stateParams.id);
        if(!Authentication.isOwner($stateParams.id)){
            PendingFriend.show($scope.user.id).success(function(data){
                $scope.pendingButton = data.status;
                if(data.status == false){
                    Friend.show($scope.user.id).success(function(data){
                        $scope.requestMessage = "Hello " + $scope.user.first_name+ ", I'd like to add you as friend !"
                        $scope.addFriendButton = !data.status;
                    })
                }
            });
        }
    }, function(error){
        $location.path('home');
    });

    $scope.handleFriendRequest = function(){
        var data = {
            'data': {
                'type': 'friend_request',
                'attributes': {
                    'id': $scope.user.id,
                    'message': $scope.requestMessage
                }
            }
        }
        FriendRequest.create($scope.user.id, data).success(function(data){
            $scope.pendingButton = true;
            $scope.addFriendButton = false;
        })
    }
}]);
angular.module('Learnento').controller('UsersShowController', ['$stateParams', 'User', '$location', '$scope', 'Authentication', 'PendingFriend', 'Friend',  function($stateParams, User, $location, $scope, Authentication, PendingFriend, Friend) {
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
                        $scope.addFriendButton = !data.status;
                    })
                }
            });
        }
    }, function(error){
        $location.path('home');
    });
}]);
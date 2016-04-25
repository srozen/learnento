angular.module('Learnento').controller('UsersShowController', ['$stateParams', 'User', '$location', '$scope', 'Authentication', 'PendingFriend',  function($stateParams, User, $location, $scope, Authentication, PendingFriend) {
    if(!Authentication.loggedIn()){
        $location.path('home');
    }

    User.show($stateParams.id).then(function(response){
        $scope.user = response.data;
        $scope.editButton = Authentication.isOwner($stateParams.id);
        if(!Authentication.isOwner($stateParams.id)){
            PendingFriend.show($scope.user.id).success(function(data){
                console.log(data);
            })
        }
    }, function(error){
        $location.path('home');
    });
}]);
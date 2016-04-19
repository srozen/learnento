angular.module('Learnento').controller('UsersShowController', ['$stateParams', 'User', '$location', '$scope', 'Authentication', function($stateParams, User, $location, $scope, Authentication) {
    if(!Authentication.loggedIn()){
        $location.path('home');
    }

    User.show($stateParams.id).then(function(response){
        $scope.user = response.data;
        $scope.editButton = Authentication.isOwner($stateParams.id);
    }, function(error){
        $location.path('home');
    });
}]);
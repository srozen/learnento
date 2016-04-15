angular.module('Learnento').controller('UsersShowController', ['$stateParams', 'User', '$location', '$scope', function($stateParams, User, $location, $scope) {
    User.show($stateParams.id).then(function(response){
        $scope.user = response.data;
    }, function(error){
        $location.path('home');
    });
}]);
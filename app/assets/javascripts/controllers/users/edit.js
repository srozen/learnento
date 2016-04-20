angular.module('Learnento').controller('UsersEditController', ['$stateParams', 'User', '$location', '$scope', 'Authentication', function($stateParams, User, $location, $scope, Authentication) {
    if(!Authentication.isOwner($stateParams.id)){
        $location.path('home');
    }
    $scope.user = Authentication.currentUser();

    $scope.handleEdit = function(){}
}]);
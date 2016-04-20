angular.module('Learnento').controller('UsersEditController', ['$stateParams', 'User', '$location', '$scope', 'Authentication', function($stateParams, User, $location, $scope, Authentication) {
    if(!Authentication.isOwner($stateParams.id)){
        $location.path('home');
    }
    $scope.user = Authentication.currentUser();

    $scope.handleEdit = function(){
        var data = {
            'data': {
                'type': 'user',
                'attributes': {
                    'first_name': $scope.firstname,
                    'last_name': $scope.lastname,
                    'avatar': {
                        'data': $scope.avatar.base64,
                        'name': $scope.avatar.filename
                    }
                }
            }
        };

        User.update($scope.user.id, data).then(function(){
            $location.path('/users/'+Authentication.currentUser().id);
        }, function(){
            $scope.error_message = response.data.error;
        });
    }
}]);
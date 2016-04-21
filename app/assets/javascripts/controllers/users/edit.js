angular.module('Learnento').controller('UsersEditController', ['$stateParams', 'User', '$location', '$scope', 'Authentication', function($stateParams, User, $location, $scope, Authentication) {
    if(!Authentication.isOwner($stateParams.id)){
        $location.path('home');
    }
    $scope.currentUser = Authentication.currentUser();

    User.show($stateParams.id).then(function(response){
        $scope.user = response.data;
        $scope.firstname = response.data.first_name;
        $scope.lastname = response.data.last_name;
    }, function(error){
        $location.path('home');
    });

    $scope.handleEdit = function(){
        if ($scope.avatar != null){
            var avatar = {
                'data': $scope.avatar.base64,
                'name': $scope.avatar.filename
            };
        } else {
            var avatar = null;
        }
        var data = {
            'data': {
                'type': 'user',
                'attributes': {
                    'first_name': $scope.firstname,
                    'last_name': $scope.lastname,
                    'avatar': avatar
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
angular.module('Learnento').controller('LoginController', ['Authentication', '$location', '$scope', function(Authentication, $location, $scope){

    $scope.email = '';
    $scope.password = '';

    $scope.handleLogin = function(){
        var data = {
            "data":{
                "type": "user",
                "attributes": {
                    "email": $scope.email,
                    "password": $scope.password
                }
            }
        };
        Authentication.login(data).then(function(){
            $location.path('home');
        }, function(){
            $scope.error_message = "Bad Login/Password"
        })
    }
}]);
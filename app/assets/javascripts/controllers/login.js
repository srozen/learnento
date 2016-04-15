angular.module('Learnento').controller('LoginController', ['Authentication', '$location', '$scope', function(Authentication, $location, $scope){
    if(Authentication.loggedIn()){
        $location.path('home');
    }

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
            $location.path('/users/'+Authentication.currentUser().id);
        }, function(){
            $scope.error_message = "Bad Login/Password"
        })
    }
}]);
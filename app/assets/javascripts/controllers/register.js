angular.module('Learnento').controller('RegisterController', ['Authentication', '$location', '$scope', function(Authentication, $location, $scope){

    $scope.email = '';
    $scope.password = '';
    $scope.password_confirmation= '';

    $scope.handleRegister = function(){
        var data = {
            "data":{
                "type": "user",
                "attributes": {
                    "email": $scope.email,
                    "password": $scope.password,
                    "password_confirmation": $scope.password_confirmation
                }
            }
        };
        Authentication.register(data).then(function(){
            $location.path('home');
        }, function(response){
            $scope.error_message = response.data.error;
        })
    }
}]);
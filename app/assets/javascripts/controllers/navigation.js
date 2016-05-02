angular.module('Learnento').controller('NavigationController', ['Authentication', '$scope', '$rootScope', function(Authentication, $scope, $rootScope){

    var connectSocket = function(){
        if($scope.loggedIn){
            $rootScope.socket = io.connect('http://localhost:5001');
            $rootScope.socket.on('message', function(message) {
                alert('Le serveur a un message pour vous : ' + message.content);
            })
        }
    }

    $scope.loggedIn = Authentication.loggedIn();
    $scope.currentUser = Authentication.currentUser();

    connectSocket();

    $scope.logout = function(){
        Authentication.logout();
    };

    $rootScope.$on('logout', function(){
        $scope.loggedIn = false;
    });
    $rootScope.$on('login', function(){
        $scope.loggedIn = true;
        $scope.currentUser = $rootScope.currentUser;
        connectSocket();
    });
}]);
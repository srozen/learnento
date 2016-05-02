angular.module('Learnento').controller('NavigationController', ['Authentication', '$scope', '$rootScope', function(Authentication, $scope, $rootScope){

    $scope.loggedIn = Authentication.loggedIn();
    $scope.currentUser = Authentication.currentUser();

    var connectSocket = function(){
        if($scope.loggedIn){
            $rootScope.socket = io.connect('http://localhost:5001');

            $rootScope.socket.on('connect', function(data){
                $rootScope.socket.emit('storeUserId', {id: $scope.currentUser.id})
            });

            $rootScope.socket.on('friendRequest', function(data){
                alert(data.message);
            })
        }
    }

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
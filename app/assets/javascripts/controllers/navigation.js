angular.module('Learnento').controller('NavigationController', ['Authentication', '$scope', '$rootScope', function(Authentication, $scope, $rootScope){

    $scope.loggedIn = Authentication.loggedIn();
    $scope.currentUser = Authentication.currentUser();

    var addFriendNotification = function(num){
        $scope.friendNotification = num;
    };

    var connectSocket = function(){
        if($scope.loggedIn){
            $rootScope.socket = io.connect('http://localhost:5001');

            $rootScope.socket.on('connect', function(data){
                $rootScope.socket.emit('storeUserId', {id: $scope.currentUser.id})
            });

            $rootScope.socket.on('friendRequest', function(data){
                $scope.$apply(addFriendNotification(1));
            })
        }
    };

    connectSocket();

    $scope.logout = function(){
        Authentication.logout();
    };

    $scope.clearFriendNotification = function(){
        $scope.friendNotification = 0;
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
angular.module('Learnento').controller('NavigationController', ['Authentication', '$scope', '$rootScope', 'Notification', function(Authentication, $scope, $rootScope, Notification){

    $scope.loggedIn = Authentication.loggedIn();
    $scope.currentUser = Authentication.currentUser();
    $scope.friendNotification = 0;


    var addFriendNotification = function(num){
        $scope.friendNotification = num;
    };

    var connectSocket = function(){
        if($scope.loggedIn){

            $rootScope.socket = io.connect('http://46.101.155.249:5001');

            $rootScope.socket.on('connect', function(data){
                $rootScope.socket.emit('storeUserId', {id: $scope.currentUser.id});

                Notification.activeFriendNotifications().success(function(data){
                    $scope.friendNotification = data.number;
                });
            });

            $rootScope.socket.on('friendRequest', function(data){
                $scope.$apply($scope.friendNotification++);
            })
        }
    };


    connectSocket();

    $scope.logout = function(){
        Authentication.logout();
    };

    $scope.clearFriendNotification = function(){
        Notification.clearFriendNotifications($scope.currentUser.id).success(function(data){
            $scope.friendNotification = data.number;
        });
    };

    $rootScope.$on('logout', function(){
        $scope.loggedIn = false;
    });
    $rootScope.$on('login', function(){
        $scope.loggedIn = Authentication.loggedIn();
        $scope.currentUser = $rootScope.currentUser;
        connectSocket();
    });
}]);
angular.module('Learnento').controller('FriendsIndexController', ['$scope', 'Friend', 'Authentication', '$location', function($scope, Friend, Authentication, $location){

    if(!Authentication.loggedIn()){
        $location.path('home');
    }


    Friend.all().success(function(data){
        $scope.friends = data.friends;
        $scope.blocked = data.blocked_friends;

    })
}]);
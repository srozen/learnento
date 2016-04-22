angular.module('Learnento').controller('FriendRequestsIndexController', ['$scope', 'FriendRequest', 'Authentication', '$location', function($scope, FriendRequest, Authentication, $location){

    if(!Authentication.loggedIn()){
        $location.path('home');
    }

    FriendRequest.all().success(function(data){
        $scope.requests = data.friend_requests;
        $scope.pendings = data.pending_requests;
    })
}]);
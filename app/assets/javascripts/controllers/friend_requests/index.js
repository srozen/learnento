angular.module('Learnento').controller('FriendRequestsIndexController', ['$scope', 'FriendRequest', 'Authentication', '$location', function($scope, FriendRequest, Authentication, $location){

    if(!Authentication.loggedIn()){
        $location.path('home');
    }

    $scope.acceptRequest = function(idx, id){
        var data = {
            data: {
                'type': 'friend_request',
                'attributes': {
                    'id': id
                }
            }
        };
        FriendRequest.accept(id, data).success(function(){
            $scope.requests.splice(idx, 1);
        })
    };

    $scope.declineRequest = function(idx, id){
        var data = {
            data: {
                'type': 'friend_request',
                'attributes': {
                    'id': id
                }
            }
        };
        FriendRequest.destroy(id, data).success(function(){
            $scope.requests.splice(idx, 1);
        })
    };

    $scope.cancelRequest = function(idx, id){
        var data = {
            data: {
                'type': 'friend_request',
                'attributes': {
                    'id': id
                }
            }
        };
        FriendRequest.destroy(id, data).success(function(){
            $scope.pendings.splice(idx, 1);
        })
    };

    FriendRequest.all().success(function(data){
        $scope.requests = data.friend_requests;
        $scope.pendings = data.pending_requests;
        angular.forEach($scope.requests, function(request){
            FriendRequest.show(request.id).success(function(data){
                request.message = data.message;
            });
        });
    })
}]);
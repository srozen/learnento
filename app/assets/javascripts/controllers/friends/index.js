angular.module('Learnento').controller('FriendsIndexController', ['$scope', 'Friend', 'Authentication', '$location', '$document', '$rootScope', function($scope, Friend, Authentication, $location, $document, $rootScope){

    if(!Authentication.loggedIn()){
        $location.path('home');
    }


    Friend.all().success(function(data){
        $scope.friends = data.friends;

        angular.forEach($scope.friends, function(friend){
            $rootScope.socket.emit('checkConnection', {id: friend.id});
            $rootScope.socket.on('connectionStatus' + friend.id , function(data){
                $scope.$apply(friend['connected'] = data);
            });
        });

        $scope.blockeds = data.blocked_friends;

    });

    $scope.deleteFriend = function(idx, id){
        Friend.delete(id).success(function(){
            $scope.friends.splice(idx, 1);
            angular.element($document[0].getElementsByClassName('modal-backdrop')).remove();
        });
    };

    $scope.blockFriend = function(idx, id){
        var data = {
            'data':{
                'type': 'friend_request',
                'attributes': {
                    'id': id,
                    'action': 'block'
                }
            }
        };
        Friend.update(id, data).success(function(){
            $scope.blockeds.push($scope.friends[idx]);
            $scope.friends.splice(idx, 1);
            angular.element($document[0].getElementsByClassName('modal-backdrop')).remove();
        })
    };

    $scope.unblockFriend = function(idx, id){
        var data = {
            'data':{
                'type': 'friend_request',
                'attributes': {
                    'id': id,
                    'action': 'unblock'
                }
            }
        };
        Friend.update(id, data).success(function(){
            $scope.friends.push($scope.blockeds[idx]);
            $scope.blockeds.splice(idx, 1);
            angular.element($document[0].getElementsByClassName('modal-backdrop')).remove();
        })
    };

}]);
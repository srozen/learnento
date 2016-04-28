angular.module('Learnento').controller('FriendsIndexController', ['$scope', 'Friend', 'Authentication', '$location', '$document', function($scope, Friend, Authentication, $location, $document){

    if(!Authentication.loggedIn()){
        $location.path('home');
    }


    Friend.all().success(function(data){
        $scope.friends = data.friends;
        $scope.blocked = data.blocked_friends;

    });

    $scope.deleteFriend = function(idx, id){
        Friend.delete(id).success(function(){
            $scope.friends.splice(idx, 1);
            angular.element($document[0].getElementsByClassName('modal-backdrop')).remove();
        });
    }
}]);
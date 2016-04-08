angular.module('Learnento').controller('UserSearchController', ['$scope', 'User', function($scope, User){
    $scope.users = []
    $scope.search = function(searchTerm) {
        var params = {'keywords': searchTerm}
        User.all(params).success(function(data){
            $scope.users = data;
        });
    }
}]);

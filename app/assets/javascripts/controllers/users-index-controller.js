angular.module('Learnento').controller('UsersIndexController', ['$scope', 'User', function($scope, User){
    var page = 0;

    User.all().success(function(data){
        $scope.users = data;
    });

    $scope.search = function(searchTerm, page) {
        var params = {'keywords': searchTerm, 'page': page};
        User.all(params).success(function(data){
            $scope.users = data;
        });
    };

    $scope.userLink = function(id) {
        return '/users/'+id;
    };

    $scope.previousPage = function(){
        if (page > 0) {
            page--;
            $scope.search($scope.keywords, page);
        }
    };

    $scope.nextPage = function(){
        page++;
        $scope.search($scope.keywords, page);
    };
}]);

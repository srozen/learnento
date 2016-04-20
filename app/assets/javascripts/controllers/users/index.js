angular.module('Learnento').controller('UsersIndexController', ['$scope', 'User', 'Authentication', '$location', function($scope, User, Authentication, $location){

    if(!Authentication.loggedIn()){
        $location.path('home');
    }

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
        return '#/users/'+id;
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

    $scope.zeroPage = function(){
        return (page == 0);
    }
}]);
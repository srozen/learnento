angular.module('Learnento').controller('NavigationController', ['Authentication', '$scope', '$rootScope', function(Authentication, $scope, $rootScope){
    $scope.loggedIn = Authentication.loggedIn();
    $scope.logout = function(){
        Authentication.logout();
    };

    $rootScope.$on('logout', function(){
        $scope.loggedIn = false;
    });
    $rootScope.$on('login', function(){
        $scope.loggedIn = true;
        $scope.currentUser = $rootScope.currentUser;
    });
}]);
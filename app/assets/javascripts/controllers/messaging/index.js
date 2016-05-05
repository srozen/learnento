angular.module('Learnento').controller('MessagingIndexController', ['$scope', 'Authentication', '$location', '$document', function($scope, Authentication, $location, $document){

    if(!Authentication.loggedIn()){
        $location.path('home');
    }
}]);
angular.module('Learnento')
    .config(['$httpProvider', function($httpProvider){
        $httpProvider.defaults.headers.common['Accept'] = 'application/vnd.learnento+json; version=1'
        $httpProvider.defaults.headers.common['Content-Type'] = 'application/vnd.learnento+json; version=1'
    }]);
angular.module('Learnento').config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider){
    $stateProvider
        .state('home', {
            url: '/home',
            templateUrl: 'index/home.html'
        })
        .state('login', {
            url: '/login',
            templateUrl: 'index/login.html'
        })
        .state('register', {
            url: '/register',
            templateUrl: 'index/register.html',
        });
    $urlRouterProvider.otherwise('home');
}]);
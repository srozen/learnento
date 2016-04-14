angular.module('Learnento').config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider){
    $stateProvider
        .state('home', {
            url: '/home',
            templateUrl: 'index/home.html'
        })
        .state('login', {
            url: '/login',
            templateUrl: 'index/login.html',
            controller: 'LoginController'
        })
        .state('register', {
            url: '/register',
            templateUrl: 'index/register.html',
            controller: 'RegisterController'
        });
    $urlRouterProvider.otherwise('home');
}]);
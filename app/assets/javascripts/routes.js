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
        })
        .state('profile', {
            url: '/users/:id',
            templateUrl: 'users/show.html',
            controller: 'UsersShowController'
        });
    $urlRouterProvider.otherwise('home');
}]);
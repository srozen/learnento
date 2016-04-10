angular.module('Learnento').config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider){
    $stateProvider
        .state('home', {
            url: '/home',
            controller: 'MainController',
            templateUrl: 'main/home.html'
        })
        .state('users', {
            url: '/users',
            controller: 'UsersIndexController',
            templateUrl: 'users/index.html',
            onEnter: ['$state', 'Auth', function($state, Auth) {
                Auth.currentUser().then(function (){

                }, function(){
                    $state.go('home');
                })
            }]
        })
        .state('login', {
            url: '/login',
            templateUrl: 'authentication/_login.html',
            controller: 'AuthenticationController',
            onEnter: ['$state', 'Auth', function($state, Auth) {
                Auth.currentUser().then(function (){
                    $state.go('home');
                })
            }]
        })
        .state('register', {
            url: '/register',
            templateUrl: 'authentication/_register.html',
            controller: 'AuthenticationController',
            onEnter: ['$state', 'Auth', function($state, Auth) {
                Auth.currentUser().then(function (){
                    $state.go('home');
                })
            }]
        });

    $urlRouterProvider.otherwise('home');
}]);
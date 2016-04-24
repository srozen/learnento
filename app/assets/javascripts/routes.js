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
        })
        .state('edit_profile', {
            url: '/users/edit/:id',
            templateUrl: 'users/edit.html',
            controller: 'UsersEditController'
        })
        .state('users', {
            url: '/users',
            templateUrl: 'users/index.html',
            controller: 'UsersIndexController'
        })
        .state('friend_requests', {
            url: '/friend_requests',
            templateUrl: 'friend_requests/index.html',
            controller: 'FriendRequestsIndexController'
        })
        .state('friends', {
            url: '/friends',
            templateUrl: 'friends/index.html',
            controller: 'FriendsIndexController'
        });
    $urlRouterProvider.otherwise('home');
}]);
angular.module('Learnento').service('Authentication', ['$http', '$window', '$rootScope', function AuthenticationService($http, $window, $rootScope){
    var saveToken = function(token){
        $window.localStorage['learnenToken'] = token;
    };
    var getToken = function(){
        return $window.localStorage['learnenToken'];
    };
    var logout = function(){
        $window.localStorage.removeItem('learnenToken');
        $rootScope.currentUser = null;
        $rootScope.$broadcast('logout');
    };
    var loggedIn = function() {
        return getToken();
    };
    var currentUser = function() {
        if (loggedIn()) {
            var token = getToken();
            var payload = token.split('.')[1];
            payload = $window.atob(payload);
            payload = JSON.parse(payload);
            return {
                id: payload.id,
                email: payload.email
            };
        }
    };

    var isOwner = function(id){
        return (loggedIn() && (id == currentUser().id))
    };

    var register = function(registerData) {
        return $http({
            method: 'POST',
            url: '/api/users',
            data: registerData
        }).then(function(response){
            var token = response.data.token;
            var payload = token.split('.')[1];
            payload = $window.atob(payload);
            payload = JSON.parse(payload);
            $rootScope.currentUser = {
                id: payload.id,
                email: payload.email
            };
            $rootScope.$broadcast('login');
            saveToken(response.data.token);
        });
    };

    var login = function(loginData) {
        return $http({
            method: 'POST',
            url: '/api/sessions',
            data: loginData
        }).then(function(response) {
            var token = response.data.token;
            var payload = token.split('.')[1];
            payload = $window.atob(payload);
            payload = JSON.parse(payload);
            $rootScope.currentUser = {
                id: payload.id,
                email: payload.email
            };
            $rootScope.$broadcast('login');
            saveToken(response.data.token);
        });
    };

    return {
        saveToken: saveToken,
        getToken: getToken,
        logout: logout,
        loggedIn: loggedIn,
        currentUser: currentUser,
        register: register,
        login: login,
        isOwner: isOwner
    }
}]);
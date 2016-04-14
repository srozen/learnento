(function(){
    angular.module('Learnento').service('Authentication', ['$http', '$window', '$rootScope', function AuthenticationService($http, $window, $rootScope){
        var saveToken = function(token){
            $window.localStorage['learnenToken'] = token;
        };
        var getToken = function(){
            return $window.localStorage['learnenToken'];
        };
        var logout = function(){
            $window.localStorage.removeItem('learnenToken')
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

        var register = function(registerData) {
            return $http({
                method: 'POST',
                url: '/api/users',
                data: registerData,
                headers: {
                    'Content-Type': 'application/vnd.learnento+json; version=1',
                    'Accept': 'application/vnd.learnento+json; version=1'
                }
            }).then(function(data){
                $rootScope.$broadcast('login');
                saveToken(data.token);
            });
        };

        var login = function(loginData) {
            return $http({
                method: 'POST',
                url: '/api/sessions',
                data: loginData,
                headers: {
                    'Content-Type': 'application/vnd.learnento+json; version=1',
                    'Accept': 'application/vnd.learnento+json; version=1'
                }
            }).then(function(data) {
                $rootScope.$broadcast('login');
                saveToken(data.token);
            });
        };

        return {
            saveToken: saveToken,
            getToken: getToken,
            logout: logout,
            loggedIn: loggedIn,
            currentUser: currentUser,
            register: register,
            login: login
        }
    }]);
})();
angular.module('Learnento').factory('User', function UserFactory($http){
   return {
        all: function(params){
            return $http({method: 'GET', url: '/users.json', params: params})
        }
    }
});
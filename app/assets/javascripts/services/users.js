angular.module('Learnento').service('User', ['$http', 'Authentication', function UserFactory($http, Authentication){
    return {
        show: function(id){
            var headers = {
                Authorization: 'Bearer '+ Authentication.getToken()
            };
            return $http({
                method: 'GET',
                url: '/api/users/'+id,
                data: '',
                headers: headers
            })
        },
        all: function(params){
            var headers = {
                Authorization: 'Bearer '+ Authentication.getToken()
            };
            return $http({
                method: 'GET',
                url: '/api/users',
                params: params,
                headers: headers
            })
        },
        update: function(id, editData){
            var headers = {
                Authorization: 'Bearer '+ Authentication.getToken()
            };
            return $http({
                method: 'PUT',
                url: '/api/users/'+id,
                data: editData,
                headers: headers
            })
        }
    }
}]);

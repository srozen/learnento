angular.module('Learnento').service('User', ['$http', 'Authentication', function UserFactory($http, Authentication){
    var headers = {
            Authorization: 'Bearer '+ Authentication.getToken()
    };
    return {
        show: function(id){
            return $http({
                method: 'GET',
                url: '/api/users/'+id,
                data: '',
                headers: headers
            })
        },
        all: function(params){
            return $http({
                method: 'GET',
                url: '/api/users',
                params: params,
                headers: headers
            })
        },
        update: function(id, editData){
            return $http({
                method: 'PUT',
                url: '/api/users/'+id,
                data: editData,
                headers: headers
            })
        }
    }
}]);

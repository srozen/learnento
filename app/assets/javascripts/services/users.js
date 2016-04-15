(function(){
    angular.module('Learnento').service('User', ['$http', 'Authentication', function UserFactory($http, Authentication){
        var headers = {
            'Content-Type': 'application/vnd.learnento+json; version=1',
                'Accept': 'application/vnd.learnento+json; version=1',
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
            }
        }
    }]);
})();
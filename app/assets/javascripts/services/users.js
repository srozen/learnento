(function(){
    angular.module('Learnento').service('User', ['$http', 'Authentication', function UserFactory($http, Authentication){
        return {
            show: function(id){
                return $http({
                    method: 'GET',
                    url: '/api/users/'+id,
                    data: '',
                    headers: {
                        'Content-Type': 'application/vnd.learnento+json; version=1',
                        'Accept': 'application/vnd.learnento+json; version=1',
                        Authorization: 'Bearer '+ Authentication.getToken()
                    }
                })
            }
        }
    }]);
})();
angular.module('Learnento').service('Friend', ['$http', 'Authentication', function FriendFactory($http, Authentication){
    var headers = {
        Authorization: 'Bearer '+ Authentication.getToken()
    };
    return {
        all: function(){
            return $http({
                method: 'GET',
                url: '/api/friends',
                data: '',
                headers: headers
            })
        },
        show: function(id){
            return $http({
                method: 'GET',
                url: '/api/friends/'+id,
                data: '',
                headers: headers
            })
        }
    }
}]);

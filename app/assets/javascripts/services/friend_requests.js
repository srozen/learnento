angular.module('Learnento').service('FriendRequest', ['$http', 'Authentication', function FriendRequestFactory($http, Authentication){
    var headers = {
        Authorization: 'Bearer '+ Authentication.getToken()
    };
    return {
        all: function(){
            return $http({
                method: 'GET',
                url: '/api/friend_requests',
                data: '',
                headers: headers
            })
        },
        show: function(id){
            return $http({
                method: 'GET',
                url: '/api/friend_requests/'+id,
                data: '',
                headers: headers
            })
        },
        accept: function(id, data){
            return $http({
                method: 'PUT',
                url: 'api/friend_requests/'+id,
                data: data,
                headers: headers
            })
        },
        destroy: function(id, data){
            return $http({
                method: 'DELETE',
                url: 'api/friend_requests/'+id,
                data: data,
                headers: headers
            })
        }
    }
}]);

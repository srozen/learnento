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
        }
    }
}]);

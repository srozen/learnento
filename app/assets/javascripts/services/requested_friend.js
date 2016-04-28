angular.module('Learnento').service('RequestedFriend', ['$http', 'Authentication', function RequestedFriendFactory($http, Authentication){
    var headers = {
        Authorization: 'Bearer '+ Authentication.getToken()
    };
    return {
        show: function(id){
            return $http({
                method: 'GET',
                url: '/api/requested_friends/'+id,
                data: '',
                headers: headers
            })
        }
    }
}]);

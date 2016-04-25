angular.module('Learnento').service('PendingFriend', ['$http', 'Authentication', function PendingFriendFactory($http, Authentication){
    var headers = {
        Authorization: 'Bearer '+ Authentication.getToken()
    };
    return {
        show: function(id){
            return $http({
                method: 'GET',
                url: '/api/pending_friends/'+id,
                data: '',
                headers: headers
            })
        }
    }
}]);

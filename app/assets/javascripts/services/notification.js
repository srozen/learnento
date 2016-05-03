angular.module('Learnento').service('Notification', ['$http', 'Authentication', function NotificationFactory($http, Authentication){

    return {
        activeFriendNotifications: function(){
            var headers = {
                Authorization: 'Bearer '+ Authentication.getToken()
            };
            return $http({
                method: 'GET',
                url: 'api/active_friend_notifications',
                data: '',
                headers: headers
            })
        },
        clearFriendNotifications: function(id){
            var headers = {
                Authorization: 'Bearer '+ Authentication.getToken()
            };
            return $http({
                method: 'DELETE',
                url: 'api/active_friend_notifications/' + id,
                data: '',
                headers: headers
            })
        }
    }
}])
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
        },
        activeMessagingNotifications: function(){
            var headers = {
                Authorization: 'Bearer '+ Authentication.getToken()
            };
            return $http({
                method: 'GET',
                url: 'api/active_messaging_notifications',
                data: '',
                headers: headers
            })
        },
        clearMessagingNotifications: function(id){
            var headers = {
                Authorization: 'Bearer '+ Authentication.getToken()
            };
            return $http({
                method: 'DELETE',
                url: 'api/active_messaging_notifications/' + id,
                data: '',
                headers: headers
            })
        },
        activeConversationNotification: function(id){
            var headers = {
                Authorization: 'Bearer '+ Authentication.getToken()
            };
            return $http({
                method: 'GET',
                url: 'api/conversation_notifications/' + id,
                data: '',
                headers: headers
            })
        },
        clearConversationNotification: function(id){
            var headers = {
                Authorization: 'Bearer '+ Authentication.getToken()
            };
            return $http({
                method: 'PUT',
                url: 'api/conversation_notifications/' + id,
                data: '',
                headers: headers
            })
        }
    }
}]);
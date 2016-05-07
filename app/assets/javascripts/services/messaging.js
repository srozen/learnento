angular.module('Learnento').service('Messaging', ['$http', 'Authentication', function MessagingFactory($http, Authentication){

    var headers = {
        Authorization: 'Bearer '+ Authentication.getToken()
    };

    return {
        all: function(){
            return $http({
                method: 'GET',
                url: 'api/conversations',
                data: '',
                headers: headers
            })
        },
        show: function(id){
            return $http({
                method: 'GET',
                url: 'api/conversations/'+ id,
                data: '',
                headers: headers
            })
        },
        create: function(data){
            return $http({
                method: 'POST',
                url: 'api/messages',
                data: data,
                headers: headers
            })
        }
    }
}]);
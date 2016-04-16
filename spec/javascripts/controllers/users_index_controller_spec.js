describe("UsersIndexController", function() {
    describe("Initialization", function() {

        var scope       = null,
            controller  = null,
            httpBackend = null,
            serverResults = [
                {
                    id: 123,
                    first_name: "Bob",
                    last_name: "Jones",
                    email: "bjones@foo.net"
                },
                {
                    id: 456,
                    first_name: "Bob",
                    last_name: "Johnsons",
                    email: "johnboy@bar.info"
                }
            ];

        beforeEach(module("Learnento"));

        beforeEach(inject(function ($controller, $rootScope, $httpBackend) {
            scope       = $rootScope.$new();
            httpBackend = $httpBackend;
            controller  = $controller("UsersIndexController", {
                $scope: scope
            });
        }));

        beforeEach(function() {
            httpBackend.when('GET','/api/users').
            respond(serverResults);
        });

        it("defaults to an full users list", function() {
            httpBackend.flush();
            expect(scope.users).toEqualData(serverResults);
        });
    });

    describe("Fetching Search Results", function() {
        var scope       = null,
            controller  = null,
            httpBackend = null,
            serverResults = [
                {
                    id: 123,
                    first_name: "Bob",
                    last_name: "Jones",
                    email: "bjones@foo.net"
                },
                {
                    id: 456,
                    first_name: "Bob",
                    last_name: "Johnsons",
                    email: "johnboy@bar.info"
                }
            ];

        beforeEach(module("Learnento"));


        beforeEach(inject(function ($controller, $rootScope, $httpBackend) {
            scope       = $rootScope.$new();
            httpBackend = $httpBackend;
            controller  = $controller("UsersIndexController", {
                $scope: scope
            });
        }));

        beforeEach(function() {
            httpBackend.whenGET('/api/users').
            respond(serverResults);
        });

        beforeEach(function() {
            httpBackend.whenGET('/api/users?keywords=bob&page=0').
            respond(serverResults);
        });

        // previous setup code

        it("populates the user list with the requested results", function() {
            httpBackend.flush();
            scope.search("bob", 0);
            httpBackend.flush();
            expect(scope.users).toEqualData(serverResults);
        });
    });

});
function HomeCtrl($scope, $http) {
	$http.get('/userlist').success(function(data) {
		$scope.userlist = data;
	});
}
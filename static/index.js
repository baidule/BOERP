function HomeCtrl($scope, $http) {
	$scope.getlist = function() {

		$http.get('/user').success(function(data) {
			$scope.userlist = data;
		});
	};
	$scope.getlist();
	$scope.creating = {};
	$scope.add = function($event) {
		$event.preventDefault();
		$http.post('/user', $scope.creating).success(function(data) {
			if (data && data.success == '1') {
				alert('success');
				$scope.getlist();
			} else
				alert(data);
		});
	};
	$scope.delete = function($event, id) {
		$event.preventDefault();
		$http.delete('/user/' + id).success(function(data) {
			$scope.getlist();
		});
	}
}
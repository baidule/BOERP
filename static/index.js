function HomeCtrl($scope, $http) {
	$scope.getlist = function() {

		$http.get('/users').success(function(data) {
			$scope.userlist = data;
		});
	};
	$scope.getlist();
	$scope.creating = {};
	$scope.add = function($event) {
		$event.preventDefault();
		$http.post('/users', $scope.creating).success(function(data) {
			if (data && data.success == '1') {
				alert('success');
				$scope.getlist();
			} else
				alert(data);
		});
	};
	$scope.delete = function($event, id) {
		$event.preventDefault();
		$http.delete('/users/' + id).success(function(data) {
			$scope.getlist();
		});
	};
}
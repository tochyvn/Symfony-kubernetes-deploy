pipeline {

    agent any

    stages {

    stage('Build') {
	    steps {
    	    script {
                 image_name = "symfony-kube-deploy"
                 dockerfile_dir = "docker/php-7-fpm/Dockerfile"
                 archive_name = "${image_name}.tgz"
                 sh "docker build -f ${dockerfile_dir} -t ${image_name} ."
                 sh "docker save ${image_name} | gzip > ${archive_name}"
	        }
   	    archiveArtifacts artifacts: "${archive_name}"

            }
         }

    stage('Clean') {
	 steps {
		script {
			sh 'docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi'
			}
		}
	}
}
    post {
	always {
		cleanWs()
		}
	}
}

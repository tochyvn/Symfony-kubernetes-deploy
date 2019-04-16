pipeline {

    agent any

    stages {

    stage('Build') {
	    steps {
    	    script {
                 image_name = "symfony-kube-deploy"
                 archive_name = "${image_name}.tgz"
		 sh "sudo docker ps"
                 sh "sudo docker build -t ${image_name} ."
                 sh "sudo docker save ${image_name} | gzip > ${archive_name}"
	        }
   	    archiveArtifacts artifacts: "${archive_name}"

            }
         }

    stage('Clean') {
	 steps {
		script {
			sh 'sudo docker images -q -f dangling=true | sudo xargs --no-run-if-empty docker rmi'
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

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
                 sh "rm -fv symfony-kube-deploy.tgz"
                 sh "wget --auth-no-challenge --user tochyvn --password TOCHlion1991 http://localhost:8080/job/Test_Symfony_Kubernete/lastSuccessfulBuild/artifact/symfony-kube-deploy.tgz"
                 sh "sudo docker rmi  localhost:5000/symfony-docker"
                 sh "sudo docker load < symfony-kube-deploy.tgz"
                 sh "sudo docker tag symfony-kube-deploy localhost:5000/symfony-docker"
                 sh "sudo docker push localhost:5000/symfony-docker"
	        }
   	        archiveArtifacts artifacts: "${archive_name}"
        }
    }

    stage('Clean') {
	 steps {
		script {
			sh 'sudo docker image prune --force'
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

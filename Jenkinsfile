node {
    def app
    def aws_testserver_ids = 'i-0acb94ab358fe82b2'
    def sonar_project = 'website'

    /*Docker Initialize*/
    stage('Initialize') {
        def dockerHome = tool 'Docker'
        env.PATH = "${dockerHome}/bin:${env.PATH}"
    }

    /*Git Repository Checkout*/
    stage('GitHub Checkout') {
        checkout scm
    }

    /*Running Static HTML Test on Sonar*/
    stage('Unit Test') {
        echo 'Starting AWS Test Server'
        sh "aws ec2 start-instances --instance-ids ${aws_testserver_ids}"
        echo 'Waiting for server initalization'
        sleep 60
        echo 'Running Sonar Scanner'

        withSonarQubeEnv('SonarQube') {
            sh "sonar-scanner -Dsonar.projectKey=${sonar_project} -Dsonar.sources=."
        }
        
        /*sleep 60
        sh "aws ec2 stop-instances --instance-ids ${aws_testserver_ids}"*/
    }

    stage("SonarQube Quality Gate") { 
        timeout(time: 1, unit: 'MINUTE') { 
           def qg = waitForQualityGate() 
           if (qg.status != 'OK') {
             error "Pipeline aborted due to quality gate failure: ${qg.status}"
           }
        }
    }


    /*Building the image using the file DockerFile
    stage('Build image') {
        app = docker.build("galloandreas/website")
    }

    /*Pushing image to repository
    stage('Push Image to Repository') {
        echo '..pushing to Docker Hub'
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }*/
}
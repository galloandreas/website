node {
    def app

    /*Git Repository Checkout*/
    try {
        stage('Checkout') {
            checkout scm
        }
    }

    /*Building the image using the file DockerFile*/
    stage('Build image') {
        app = docker.build("nginx/website")
    }

    /*Pushing image to repository*/
    stage('Push Image to Repository') {
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
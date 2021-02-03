
pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven"
    }

    stages {
        stage('Build') {
            steps {
                // Get code from a GitHub repository
                git ' https://github.com/SiyaAmonkar/JenkinsfileAssignment.git'

                // Run Maven on a Unix agent.
               sh '''cd musicstore
                mvn clean package'''

               
            }

            
        }
    }
}

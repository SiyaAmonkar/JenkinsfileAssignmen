
pipeline {
    agent any
    environment {
        UUID version = UUID.randomUUID()
        registryCredential ='docker'
	    containerName = "shraddhal/seleniumtest2"
        container_version = "1.0.0.${BUILD_ID}"
        dockerTag = "${containerName}:${container_version}"
    }

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven"
	//terraform "terraform"
    }

    stages {
        stage('Clone Repo and build maven project') {
            steps {
                // Get code from a GitHub repository
                git ' https://github.com/SiyaAmonkar/JenkinsfileAssignment.git'
		 sh script:'''
		    	touch musicstore/src/main/webapp/version.html
		      '''
		     println version
		     writeFile file: "musicstore/src/main/webapp/version.html", text: version
                // Run Maven on a Unix agent.
               sh '''cd musicstore
                mvn clean package'''

               
            }
	}

        /*stage('Dockerized Tomcat') {
		
		steps {
                	script{
			 	dockerImage = docker.build("shivani221/tomcatcontainer")
			 	docker.withRegistry( '', registryCredential ) {
                        	 dockerImage.push("$BUILD_NUMBER")
                         	dockerImage.push('latest')
				sh 'docker run -d --name tomcatcontainer -p 9090:8080 shivani221/tomcatcontainer:latest'
			 }
			}
                      }
		}*/
	     stage('Terraform-Docker image and container creation')
	    {
		    steps{
		 withCredentials([usernamePassword(credentialsId: 'siya_docker', passwordVariable: 'siya_dockerpass', usernameVariable: 'siya_dockeruser')]) {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve -var "password=$siya_dockerpass"'
                }
		    }
	    }
	    stage('Docker-compose up and run the test')
	    {
		    steps{
			  sh script:'''
			  docker-compose up -d --scale chrome=3
			  cd SeleniumTest
			  mvn -Dtest="UUIDTest.java" test -Duuid="$version" 
		          '''
			  
			   //mvn -Dtest="SearchTest.java" test
			}
	    }  
	   
	    
	     stage('Deploy on tomcat in VM and Monitor http status and version'){   
            steps{
            deploy adapters: [tomcat9(credentialsId: 'tomcat', path: '', url: 'http://devopsteamgoa.westindia.cloudapp.azure.com:8081/')], contextPath: 'musicstore', onFailure: false, war: 'musicstore/target/*.war'
            sh 'curl -I \'http://devopsteamgoa.westindia.cloudapp.azure.com:8081/musicstore/index.html\' | grep HTTP'
		script{
                def response = sh(script: 'curl http://devopsteamgoa.westindia.cloudapp.azure.com:8081/musicstore/version.html', returnStdout: true)
		 if(env.version == response)
		      echo 'Latest version deployed'
		 else
		      echo 'Older version deployed'
	         }
	    }
        }
			
			
			
     }
	post{
                    always{
                         sh 'terraform destroy --auto-approve'
			 sh 'docker-compose down'
                         }
            }
	
         
         }
	    

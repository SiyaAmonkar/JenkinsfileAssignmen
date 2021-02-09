
pipeline {
    agent any
    environment {
        UUID version = UUID.randomUUID()
       
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
		}
	     stage('Terraform-Docker image and container creation')
	    {
		    steps{
		 withCredentials([usernamePassword(credentialsId: 'siya_docker', passwordVariable: 'siya_dockerpass', usernameVariable: 'siya_dockeruser')]) {
                    sh 'terraform init'
                    sh 'terraform apply -target=module.tomcat_container -var "pass=$dockerpass" -auto-approve'
                }
		    }
	    }
	   
	    stage('Docker-compose up and run the test')
	    {
		    steps{
			  sh script:'''
			 terraform apply -auto-approve -target=module.testing_containers -var pass=""
			  cd SeleniumTest
			  mvn -Dtest="UUIDTest.java" test -Duuid="$version" 
		          '''
			   //docker-compose up -d --scale chrome=3
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
	    }*/
	     stage('Terraform-aws-tomcat')
	    {
		    steps{
			    withCredentials([string(credentialsId: 'access_key', variable: 'access_key'), string(credentialsId: 'sec_access_key', variable: 'sec_access_key')]) {
    				 sh 'cp musicstore/target/MusicStore.war aws_tomcat/MusicStore.war'
		    		sh 'terraform init'
		   		 sh 'terraform apply -target=module.deploy_aws -var "acc=$access_key" -var "sec=$sec_access_key" -auto-approve '
				}
		
                	}
		    }
	    }
	   
	    
	    
        }
			
			
			
     
	/*post{
                    always{
                         sh 'terraform destroy --auto-approve'
			// sh 'docker-compose down'
                         }
            }
	
         
         }*/
	    

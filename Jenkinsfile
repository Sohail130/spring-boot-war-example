pipeline{
    agent any
       tools {
        // give the target name supposed we need to install jdk, we need to give jdk. It will set the path of the tool for whole pipeline
        maven 'Maven' 
    }
    stages{
        stage("Test"){
            steps{
                echo "========executing Test========"
                sh "mvn --version"
                // mvn test
                sh "mvn test"
            }
        }
            stage("Build"){
            steps{
                echo "========executing Build========"
                //mvn package
                sh "mvn package"
            }
            }
            stage("Deploy on Test"){
            steps{
                echo "========Deployment on test========"
                deploy adapters: [tomcat9(credentialsId: 'tomcatcreddetails', path: '', url: 'http://65.1.130.255:8080')], contextPath: '/app', war: '**/*.war'
            }
            
        }
        stage("Deploy on Prod"){
            steps{
                echo "========Deployment on prod========"
            deploy adapters: [tomcat9(credentialsId: 'tomcatcreddetails', path: '', url: 'http://65.2.141.121:8080')], contextPath: '/app', war: '**/*.war'
            }
            
        }
    }

}

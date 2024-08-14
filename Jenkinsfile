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
                deploy adapters: [tomcat9(credentialsId: 'tomcatcreddetailsforpipeline', path: '', url: 'http://65.0.203.29:8080')], contextPath: '/app', war: '**/*.war'
            }
            
        }
        stage("Deploy on Prod"){
            steps{
                echo "========Deployment on prod========"
            deploy adapters: [tomcat9(credentialsId: 'tomcatcreddetailsforpipeline', path: '', url: 'http://13.127.189.2:8080')], contextPath: '/app', war: '**/*.war'
            }
            
        }
    }

}

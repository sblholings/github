pipeline {
    agent any
    parameters {
        choice choices: 'dev\nval\nprod', description: 'Choose environment configuration', name: 'ENV'
    }
    stages {
        stage('Get secrets') {
            steps {
	        sh " sudo rm -rf abstract-secret-storage "
                dir('abstract-secret-storage') {
		    checkout([$class: 'GitSCM', userRemoteConfigs: [[credentialsId: '49f4c9c6-5a7f-4290-9a18-cd98a99d03ec', url: 'https://github-lab.airbus-v.cloud/core-jenkins-jobs/abstract-secret-storage.git']]])
               	    sh  """ sudo ./abstract-secret-storage -o get -t var -n core -r ghe -k vaultpass > ../.vault;
                            sudo ./abstract-secret-storage -o get -t file -n core -r ghe -k sydneyb_unomee_nonprod.pem > ../sydneyb_unomee_nonprod.pem;
                        """
                }
                stash includes: '.vault, sydneyb_unomee_nonprod.pem', name: 'secrets'
            }
        }
        stage('Deploy') {
            steps {
                unstash name: 'secrets'
                script{
                   try {
                       withCredentials([usernamePassword(credentialsId: '431f077c-9a4a-11e8-9eb6-529269fb1459', usernameVariable: 'SERVICEUSER', passwordVariable: 'SERVICEPW')]) {
                            withEnv(["SERVICEUSER=${SERVICEUSER}","SERVICEPW=${SERVICEPW}"]) {
                               sh """ echo env vars are serv $SERVICEUSER $SERVICEPW
                               chmod 600 sydneyb_unomee_nonprod.pem; ansible-playbook -i inventory/ec2.py site.yml -e "env_name=$ENV" --private-key=sydneyb_unomee_nonprod.pem --vault-password-file .vault -vvv """
                           }
                       }
                   }
                   finally {
                       cleanWs()
                   }
                }
            }
        }
    }
}

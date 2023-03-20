pipeline {
    agent any

    //environment {
    //    TF_CLI_CONFIG_FILE = credentials('yc_service_acc_secret')
    //}

    stages {
        stage('get project') {
            steps {
                git 'https://github.com/elmcslay/DO_edu-VKR.git'
            }
        }

        stage('test terraform run') {
            steps {
                //sh 'cd tf configs/build_tf/'
                sh 'terraform -chdir=tf_configs/build_tf/ init'
                sh 'terraform -chdir=tf_configs/build_tf/ plan'
                sh 'terraform -chdir=tf_configs/build_tf/ apply -auto-approve'
            }
        }

        stage('test playbook run') {
            steps {
                sh 'ansible-playbook -i /tmp/test1 --become-user=jenkins --private-key=~/.ssh/build_key ansbl/ansbl_build/build.yml'
            }
        }
    }
}
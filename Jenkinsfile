pipeline {
    agent  {
        docker  {
            image "ansible:latest"
            args "-v /data:/data -v /etc/passwd:/etc/passwd -v /etc/group:/etc/group -v /var/lib/jenkins:/var/lib/jenkins"
            reuseNode true
        }
    }
    parameters {
        string(name: "GITHUB_PROJECT", defaultValue: 'git@git.eefocus.tech:devops/ansible-playbooks/ali-playbook.git', description: 'github code repository')
        gitParameter description: 'Choose branch/tag', branchFilter: '.*', defaultValue: 'master', name: 'BRANCH_TAG', type: 'PT_BRANCH_TAG', quickFilterEnabled: true, tagFilter: '*', listSize: "33"
    }
    // triggers {
    //     cron('0 23 * * *')
    // }
    // environment {
    //     BUILD_USER = ''
    // }
    options {
        // retry(2)
        timeout(time: 45, unit: 'MINUTES')
        timestamps()
    }
    stages {
        stage("start") {
            script {
                configFileProvider([configFile(fileId: '47299b19-0338-473d-a65a-8da13057663a', targetLocation: '.git/NotiFile')]) {
                  notifier = load ".git/NotiFile"
                }
                notifier.sendSlackMsg("*Started*", "#3838d8")
            }
        }
        stage("git pull") {
            steps {
                script {
                    checkout([$class: 'GitSCM', branches: [[name: "${params.BRANCH_TAG}"]], userRemoteConfigs: [[credentialsId: 'gitk', url: "${params.GITHUB_PROJECT}"]]])
                }
            }
        }
        
        stage('run playbook') {
            steps {
                withCredentials ([sshUserPrivateKey(credentialsId: 'rootk', keyFileVariable: 'SSH_KEY_FILE', usernameVariable: 'SSH_USER')]) {
                    sh "mkdir -p ~/.ssh/eefocus/"
                    sh "touch ~/.ssh/id_rsa"
                    sh "chmod 700 ~/.ssh/id_rsa;"
                    sh "cat ${SSH_KEY_FILE} | tee ~/.ssh/id_rsa"
                    sh "chmod 600 ~/.ssh/id_rsa"

                    sh "touch ~/.ssh/eefocus/id_rsa.client"
                    sh "chmod 700 ~/.ssh/eefocus/id_rsa.client"
                    sh "cat ${SSH_KEY_FILE} | tee ~/.ssh/eefocus/id_rsa.client"
                    sh "chmod 600 ~/.ssh/eefocus/id_rsa.client"

                    sh 'rm -fr ~/ansible.cfg ansible.cfg'
                    sh 'cp -fv ansible.cfg.direct ~/ansible.cfg'
                    sh 'cp -fv ansible.cfg.direct ansible.cfg'
                    // sh 'cat ~/ansible.cfg'
                    // sh 'ls -la ~/ ~/.ssh'

                    // ansiColor('xterm') {
                        ansiblePlaybook credentialsId: 'rootk', disableHostKeyChecking: true, inventory: 'inventory/hosts', playbook: 'build-env.yml', colorized: true, extras: '-D -e addition="${BUILD_URL}consuleFull"'
                        ansiblePlaybook credentialsId: 'rootk', disableHostKeyChecking: true, inventory: 'inventory/hosts', playbook: 'playbook.yml', colorized: true, extras: '-D -e host_name=common_group -e role_name=users  -e addition="${BUILD_URL}consuleFull"'
                    // }
                }
            }
        }
    }
    post {
        
        always {
            script {
                color_name="good"
                switch(currentBuild.currentResult) {
                    case "SUCCESS":
                        color_name="good"
                        break;
                    case "FAILURE":
                        color_name="danger"
                        break;
                    // case "CHANGED":
                    // case "UNSUCCESSFUL":
                    // case "UNSTABLE":
                    // case "ABORTED":
                    default:
                        color_name="#5f5f5f"
                        break;
                }
                notifier.sendResultEmailNotification("${color_name}")
                
                
            }

        }
    }
}

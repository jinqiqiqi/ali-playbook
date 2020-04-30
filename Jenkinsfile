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
    environment {
        BUILD_USER = ''
    }
    options {
        // retry(2)
        timeout(time: 45, unit: 'MINUTES')
        timestamps()
    }
    stages {
        stage("repo") {
            steps {
                sendSlackMsg("*Started*", "#3838d8")
                // git branch: "${params.BRANCH}", url: "${params.GITHUB_PROJECT}"
                checkout([$class: 'GitSCM', branches: [[name: "${params.BRANCH_TAG}"]], userRemoteConfigs: [[credentialsId: 'gitk', url: "${params.GITHUB_PROJECT}"]]])
            }
        }
        
        stage('build_bridge') {
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

                    ansiColor('xterm') {
                        ansiblePlaybook credentialsId: 'rootk', disableHostKeyChecking: true, inventory: 'inventory/hosts', playbook: 'build-env.yml', colorized: true, extras: '-e addition="${BUILD_URL}"'
                    }
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
            }

            sendEmailNotification("Result: \t${currentBuild.currentResult}\nBuild URL: \t${env.BUILD_URL}\nBranch: \t${env.GIT_BRANCH} \nDuration: \t${currentBuild.durationString}\nChange Set:\t${currentBuild.changeSets}\nLast Stage: \t${env.STAGE_NAME}")

            sendSlackMsg("*${currentBuild.currentResult}* (${currentBuild.durationString})", "${color_name}")
        }
    }
}


def sendSlackMsg(String message, String color) {
    withCredentials([string(credentialsId: 'slack-token', variable: 'slackCredentials')]) {
        slackSend teamDomain: 'bigeworld',
            channel: '#jenkins', 
            username: "${env.JOB_NAME}@9ks",
            token: slackCredentials, 
            color: "${color}",
            message: "${env.BUILD_URL}console: ${env.BRANCH_NAME} ]] ${message}."
    }
}

def sendEmailNotification(String mailBody) {
    mail to: 'qi.jin@supplyframe.cn',
        subject: "${currentBuild.currentResult} of ${currentBuild.fullDisplayName}  building @ 9ks.eefocus.com",
        body: "${mailBody}"
}
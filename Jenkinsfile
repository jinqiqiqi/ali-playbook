

pipeline {
    agent  any
    parameters {
        string(name: "GITHUB_PROJECT", defaultValue: 'https://github.com/jinqiqiqi/ali-playbook.git', description: 'github code repository')
        gitParameter branchFilter: 'origin/(.*)', defaultValue: 'master', name: 'BRANCH', type: 'PT_BRANCH_TAG', quickFilterEnabled: true, tagFilter: '*'
    }
    triggers {
        cron('0 23 * * *')
    }
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
                git branch: "${params.BRANCH}", url: "${params.GITHUB_PROJECT}"
            }
        }
        stage("start") {
            steps {
                script {
                    last_running_stage = env.STAGE_NAME
                }
                sh "mkdir -p ~/.ssh/eefocus/"
                withCredentials([string(credentialsId: 'slack-token', variable: 'slackCredentials')]) {
                    slackSend teamDomain: 'bigeworld',
                        channel: '#jenkins', 
                        token: slackCredentials, 
                        color: 'good',
                        message: "${env.JOB_NAME} #${env.BUILD_NUMBER} (${env.BUILD_URL}) has started."
                }
            }
        }
        stage('build_bridge') {
            steps {
                script {
                    last_running_stage = env.STAGE_NAME
                }
                withCredentials ([sshUserPrivateKey(credentialsId: 'rootk', keyFileVariable: 'SSH_KEY_FILE', usernameVariable: 'SSH_USER')]) {
                    sh "touch ~/.ssh/id_rsa"
                    sh "chmod 700 ~/.ssh/id_rsa;"
                    sh "cat ${SSH_KEY_FILE} | tee ~/.ssh/id_rsa"

                    sh "touch ~/.ssh/eefocus/id_rsa.client"
                    sh "chmod 700 ~/.ssh/eefocus/id_rsa.client"
                    sh "cat ${SSH_KEY_FILE} | tee ~/.ssh/eefocus/id_rsa.client"
                    sh "chmod 600 ~/.ssh/eefocus/id_rsa.client ~/.ssh/id_rsa"

                    sh 'rm -fr ansible.cfg'
                    sh 'cp -fv ansible.cfg.direct ansible.cfg'

                    ansiColor('xterm') {
                        ansiblePlaybook credentialsId: 'rootk', disableHostKeyChecking: true, inventory: 'inventory/hosts', playbook: 'build-env.yml', colorized: true, extras: '-e addition="${BUILD_URL}"'
                    }
                    // sh "chmod -Rvf 600 ~/.ssh/*"
                }
            }
        }
        // stage('build_nginx') {
        //     steps {
        //         script {
        //             last_running_stage = env.STAGE_NAME
        //         }

        //         withCredentials ([sshUserPrivateKey(credentialsId: 'rootk', keyFileVariable: 'GIT_K', usernameVariable: 'GIT_U')]) {
        //             sh "cat ${GIT_K} | tee ~/.ssh/eefocus/id_rsa.client; chmod 600 ~/.ssh/eefocus/id_rsa.client"
        //             ansiblePlaybook credentialsId: 'rootk', disableHostKeyChecking: true, inventory: 'inventory/hosts', playbook: 'nginx.yml'
        //             sh "rm -f ~/.ssh/eefocus/id_rsa.client"
        //         }
        //     }
        // }

    }
    post {
        success {
            echo "Success result. 1"
            withCredentials([string(credentialsId: 'slack-token', variable: 'slackCredentials')]) {
                slackSend teamDomain: 'bigeworld',
                    channel: '#jenkins', 
                    token: slackCredentials, 
                    color: 'good',
                    message: "${env.JOB_NAME} #${env.BUILD_NUMBER} (${env.BUILD_URL}) has result (success): ${currentBuild.currentResult}."
            }
        }
        failure {
            echo "Failure result. 2"
        }
        changed {
            echo "Changed result. 3"
        }
        always {
            echo "Always result. 4"
            sh 'rm -fv ~/.ssh/id_rsa ~/.ssh/eefocus/id_rsa.client'
            
            mail to: 'qi.jin@supplyframe.cn',
              subject: "${currentBuild.currentResult} of ${currentBuild.fullDisplayName} from [Jenkins-mailer@aliyun-eefocus]",
              body: "Result: \t${currentBuild.currentResult}\nJob Name: \t${env.JOB_NAME}\nBuild Number: \t#${env.BUILD_NUMBER}\nBuild URL: \t${env.BUILD_URL}\nBranch: \t${env.GIT_BRANCH} \nDuration: \t${currentBuild.durationString}\nChange Set:\t${currentBuild.changeSets}\nLast Stage: \t${last_running_stage}"
        }
        unstable {
            echo "Unstable result. 5"
            withCredentials([string(credentialsId: 'slack-token', variable: 'slackCredentials')]) {
                slackSend teamDomain: 'bigeworld',
                    channel: '#jenkins', 
                    token: slackCredentials, 
                    color: 'danger',
                    message: "${env.JOB_NAME} #${env.BUILD_NUMBER} (${env.BUILD_URL}) has result (unstable): ${currentBuild.currentResult}. stage: ${last_running_stage}"
            }
        }
        aborted {
            echo "Task aborted. 6"
        }
        unsuccessful {
            echo "Unsuccessful result. 7"
            withCredentials([string(credentialsId: 'slack-token', variable: 'slackCredentials')]) {
                slackSend teamDomain: 'bigeworld',
                    channel: '#jenkins', 
                    token: slackCredentials, 
                    color: 'danger',
                    message: "${env.JOB_NAME} #${env.BUILD_NUMBER} (${env.BUILD_URL}) has result (unsuccessful): ${currentBuild.currentResult}."
            }
        }
        cleanup {
            echo "Cleanup result. 8"
        }
    }
}

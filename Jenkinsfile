#!/usr/bin/env groovy

pipeline {
    agent any

	// ${{ secrets.SECRET_NAME }} PAT GitHub
 
    options {
        // skipDefaultCheckout(true)// This is required if you want to clean before build
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '5'))
        timeout(time: 48, unit: 'HOURS')
        timestamps() // add timestamps to console output
    }

    environment {
        VCPKG_DEFAULT_TRIPLET="x64-windows"
        POWERSHELL='C:/Windows/System32/WindowsPowerShell/v1.0/pwsh.exe'
	}

    stages {
        stage('Build') {
            steps {
			    echo "Build ${env.JOB_NAME} ..."
                sh 'git clone https://github.com/microsoft/vcpkg.git'
				powershell './build.ps1'
            }
        }

        stage('Test') {
           steps {
               echo 'Running tests ...'
           }
        }
  
        stage('Archive') {
            steps {
                echo 'Archiving built binaries ...'
            }
        }

        stage('Deploy') {
            when {
                expression {
                    return env.BRANCH_NAME == "master"
                }
            }
            steps {
                echo 'The installer and update package are built ...'
            }
        }    
    }

    post {
        always {
            echo 'post build'
        }
        aborted {
            echo 'build was aborted'
        }
        success {
            echo 'Build succeeded!'
        }

        unstable {
            echo 'build unstable! :/'
        }

        failure {
			echo 'failure ...'
        }

        changed {
            echo 'Things were different before...'
        }
    }
}

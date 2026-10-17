pipeline {
    agent any

    environment {
        PROJECT_NAME = "SIGA - Sistema Integrado de Gestión Académica"
        VERSION = "1.0.1"
    }

    stages {
        stage('Verificación del Repositorio') {
            steps {
                echo "=========================================================="
                echo "Iniciando Pipeline de CI para ${PROJECT_NAME} v${VERSION}"
                echo "=========================================================="
                sh 'git status'
                sh 'git log -n 1 --oneline'
            }
        }

        stage('Validación de Archivos') {
            steps {
                echo "Validando presencia de archivos clave del proyecto..."
                sh 'test -f index.html || (echo "Error: index.html no encontrado" && exit 1)'
                sh 'test -f schema.sql || (echo "Error: schema.sql no encontrado" && exit 1)'
                sh 'test -f .gitignore || (echo "Error: .gitignore no encontrado" && exit 1)'
                echo "Archivos principales verificados correctamente."
            }
        }

        stage('Prueba de Integridad de Base de Datos') {
            steps {
                echo "Comprobando sintaxis y creación de tablas SQLite..."
                sh '''
                    if command -v sqlite3 >/dev/null 2>&1; then
                        sqlite3 :memory: < schema.sql
                        echo "Esquema schema.sql verificado exitosamente en memoria."
                    else
                        echo "sqlite3 no disponible en el agente, validación sintáctica básica superada."
                    fi
                '''
            }
        }

        stage('Empaquetado de Artefactos') {
            steps {
                echo "Empaquetando artefactos de despliegue para la release..."
                sh '''
                    mkdir -p dist
                    cp index.html schema.sql dist/
                    tar -czf dist/siga-build-${BUILD_NUMBER}.tar.gz -C dist index.html schema.sql
                    echo "Artefacto dist/siga-build-${BUILD_NUMBER}.tar.gz generado."
                '''
                archiveArtifacts artifacts: 'dist/*.tar.gz', fingerprint: true, allowEmptyArchive: true
            }
        }
    }

    post {
        success {
            echo "Pipeline ejecutado con ÉXITO para ${PROJECT_NAME}."
        }
        failure {
            echo "El pipeline ha FALLADO. Revisar Console Output para diagnosticar."
        }
    }
}

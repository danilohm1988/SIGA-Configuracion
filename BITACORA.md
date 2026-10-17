# BITÁCORA DE CONTROL Y CONFIGURACIÓN DE SOFTWARE (PGCS)

**Proyecto:** SIGA - Sistema Integrado de Gestión Académica  
**Materia:** Gestión de la Configuración del Software · 8.º Semestre  
**Docente:** Ing. Deiby Torrez Maldonado  
**Equipo de Trabajo:** Danilo, Eddi & César  
**Repositorio GitHub:** [https://github.com/danilohm1988/SIGA-Configuracion](https://github.com/danilohm1988/SIGA-Configuracion)  

---

## 1. Resumen Ejecutivo de la Bitácora

Esta bitácora documenta de manera trazable cada acción, commit, rama, resolución de conflicto, tag de release y la automatización del proceso de Integración Continua (CI) con **Jenkins**.

---

## 2. Registro Cronológico de Actividades

### Actividad 1: Preparación del Repositorio y Línea Base Inicial (LB-01)
- **Responsable:** Danilo
- **Acción:** Creación del repositorio `SIGA-Configuracion` en GitHub y clonación local.
- **Ramas base creadas:** `main` (producción) y `develop` (integración).
- **Commit inicial:** `c57e940 chore(init): primer commit del proyecto SIGA`.
- **Archivos base:** `index.html` con la estructura inicial del dashboard y `repositorio-GIT.txt`.

---

### Actividad 2: Desarrollo Paralelo con Estrategia Git Flow
- **Responsables:** Danilo & César
- **Objetivo:** Simular trabajo en equipo concurrente modificando diferentes áreas del sistema.
- **Ramas creadas a partir de `develop`:**
  - `feature/estudiantes`: Modificación de la interfaz para inscripción de alumnos (`53fdde2`).
  - `feature/docentes`: Preparación del módulo de gestión de profesores.
  - `feature/base-datos`: Incorporación del esquema relacional `schema.sql` y reglas de exclusión en `.gitignore`.

---

### Actividad 3: Provocación y Resolución de Conflicto de Fusión
- **Causa del conflicto:** Ambos integrantes modificaron la misma línea del título en [`index.html`](file:///c:/Users/cesar/Desktop/DMI/automatizacion/SIGA-Configuracion/index.html):
  - En `feature/estudiantes`: `SIGA - Módulo de Estudiantes` (`fc953cc`).
  - En `feature/docentes`: `SIGA - Módulo de Docentes` (`c96a241`).
- **Diagnóstico del conflicto:**
  ```text
  Auto-merging index.html
  CONFLICT (content): Merge conflict in index.html
  Automatic merge failed; fix conflicts and then commit the result.
  ```
- **Solución Funcional aplicada:**
  En lugar de simplemente borrar los marcadores de Git (`<<<<<<<`, `=======`, `>>>>>>>`), se realizó una integración inteligente conservando ambos módulos:
  ```html
  <h1 class="text-2xl font-bold">SIGA V2.0 - Estudiantes y Docentes</h1>
  ```
- **Commit de resolución:** `855400c fix(core): resolver conflicto de titulo integrando ambos modulos`.

---

### Actividad 4: Flujo de Pull Requests y Auditoría
- **PR #1:** `feature/estudiantes` $\rightarrow$ `develop` (Aprobado y fusionado - `51f7ecf`).
- **PR #2:** `feature/docentes` $\rightarrow$ `develop` (Aprobado y fusionado - `d7d9d8a`).
- **PR #3:** `feature/materias` $\rightarrow$ `develop` (Integración del módulo de asignaturas - `e32e355`).
- **Evidencia:** Trazabilidad completa en la pestaña de Pull Requests del repositorio remoto.

---

### Actividad 5: Liberación de Versión Estable y Hotfix Crítico
- **Versión 1.0 (LB-04):**
  - Fusión de `develop` hacia `main`.
  - Creación del Tag anotado: `git tag -a v1.0 -m "Primera versión estable de SIGA"`.
- **Hotfix Urgente en Producción:**
  - Se detectó un error tipográfico crítico en producción.
  - Se creó la rama temporal de hotfix desde `main`.
  - **Commit:** `68488f1 fix(core): corregir texto urgente en produccion`.
  - Se aplicó la versión de parche formal: Tag `v1.0.1`.
  - Se sincronizó el cambio tanto en `main` como en `develop`.

---

### Actividad 6: Implementación de CI/CD con Jenkins
- **Responsable:** César
- **Objetivo:** Automatizar la validación del código y generación de artefactos tras cada commit.
- **Acciones Realizadas:**
  1. **Despliegue del Servidor:** Contenedor Docker oficial `jenkins/jenkins:lts` levantado bajo el nombre `jenkins-siga` en puertos `8080:8080` y `50000:50000`.
  2. **Diseño del Pipeline (`Jenkinsfile`):**
     - **Stage 1 (Verificación):** Comprobación del estado de Git y hash del último commit.
     - **Stage 2 (Validación de Archivos):** Verificación obligatoria de existencia de `index.html`, `schema.sql` y `.gitignore`.
     - **Stage 3 (Integridad de Base de Datos):** Prueba sintáctica y ejecución en memoria del esquema SQLite.
     - **Stage 4 (Empaquetado de Artefactos):** Generación de paquete comprimido `dist/siga-build-${BUILD_NUMBER}.tar.gz` listo para despliegue.
  3. **Documentación:** Generación de la guía de despliegue en [`README.md`](file:///c:/Users/cesar/Desktop/DMI/automatizacion/SIGA-Configuracion/README.md) y esta bitácora oficial.

---

## 3. Matriz de Elementos de Configuración (CI)

| ID Elemento | Nombre del Elemento | Ubicación | Responsable | Estado Actual |
| :--- | :--- | :--- | :--- | :--- |
| **CI-01** | Frontend Web | `index.html` | Danilo / César | Versión 2.0 (Estable) |
| **CI-02** | Esquema Base de Datos | `schema.sql` | Danilo | Validado en SQLite |
| **CI-03** | Pipeline Automatizado | `Jenkinsfile` | César | Activo / Funcional |
| **CI-04** | Guía de Configuración | `README.md` | César | Documentado |
| **CI-05** | Bitácora de PGCS | `BITACORA.md` | César | Auditado |

---

## 4. Estado de las Líneas Base (Baselines)

- **LB-01 (Requisitos y Setup):** Repositorio inicial y ramas configuradas.
- **LB-02 (Arquitectura Validada):** Integración de módulos estudiantes + docentes sin conflictos.
- **LB-03 (Release Candidato):** Integración completa de materias en rama `develop`.
- **LB-04 (Versión en Producción):** Versión `v1.0.1` desplegada con pipeline de Jenkins operativo.

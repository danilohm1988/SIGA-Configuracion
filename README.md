# SIGA - Sistema Integrado de Gestión Académica

Proyecto desarrollado para la asignatura **Gestión de la Configuración del Software (PGCS)** - 8.º Semestre, Ingeniería de Sistemas.  
Docente: **Ing. Deiby Torrez Maldonado**  
Equipo de Desarrollo: **Danilo, Eddi & Cesar**

---

## 1. Propósito y Alcance

El sistema **SIGA** es una plataforma orientada a la administración universitaria que centraliza la gestión académica. En esta fase se implementa el control avanzado de versiones bajo la estrategia **Git Flow**, resolución de conflictos, integración continua (**CI**) y automatización de despliegues con **Jenkins**.

### Módulos Principales
- **Estudiantes**: Registro, inscripción y visualización de alumnos (`feature/estudiantes`).
- **Docentes**: Asignación y gestión del cuerpo docente (`feature/docentes`).
- **Materias**: Registro y vinculación de asignaturas (`feature/materias`).
- **Base de Datos**: Esquema relacional estructurado en SQLite (`schema.sql`).
- **Automatización**: Pipeline declarativo de integración continua con Jenkins (`Jenkinsfile`).

---

## 2. Estructura del Proyecto

```text
SIGA-Configuracion/
├── .gitignore          # Exclusión de archivos de BD y temporales
├── docker-compose.yml  # Orquestación del servicio Jenkins con volúmenes
├── Jenkinsfile         # Pipeline automatizado de CI/CD para Jenkins
├── README.md           # Guía de instalación, uso y arquitectura
├── BITACORA.md         # Registro de trabajo, ramas, conflictos y cambios
├── index.html          # Panel web interactivo del sistema SIGA
├── repositorio-GIT.txt # Enlace del repositorio remoto en GitHub
└── schema.sql          # Estructura de base de datos relacional
```

---

## 3. ¿Cómo Ejecutar la Aplicación Web?

No requiere servidores complejos para la interfaz visual:
1. Abre el archivo [`index.html`](file:///c:/Users/cesar/Desktop/DMI/automatizacion/SIGA-Configuracion/index.html) directamente con doble clic en tu navegador preferido (Chrome, Edge, Firefox).
2. O levanta un servidor HTTP local rápido desde la terminal:
   ```powershell
   python -m http.server 3000
   ```
   Luego ingresa a `http://localhost:3000`.

---

## 4. Guía para Arrancar y Configurar Jenkins

### 4.1. Arrancar Jenkins con Docker Compose (Recomendado)

Solo debes ejecutar en la raíz del proyecto:

```powershell
docker compose up -d
```

*(Para detenerlo cuando termines: `docker compose down`)*

### 4.2. Método Alternativo (Docker Run directo)

```powershell
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins-siga -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts
```

### 4.2. Obtener la Contraseña Inicial de Administrador

Para desbloquear Jenkins en el primer arranque, consulta la contraseña generada en los registros del contenedor:

```powershell
docker logs jenkins-siga
```
*(O busca la clave de 32 caracteres que aparece entre dos líneas de asteriscos).*

También puedes leerla directamente del archivo interno:
```powershell
docker exec jenkins-siga cat /var/jenkins_home/secrets/initialAdminPassword
```

### 4.3. Primer Acceso en el Navegador

1. Ingresa a [http://localhost:8080](http://localhost:8080).
2. Pega la contraseña obtenida en el paso anterior y haz clic en **Continue**.
3. Selecciona **Install suggested plugins** (Instalar plugins recomendados). Esto instalará automáticamente Git, Pipeline, etc.
4. Crea tu usuario administrador (ej. `admin` / tu contraseña).
5. Guarda la URL predeterminada (`http://localhost:8080/`) y haz clic en **Start using Jenkins**.

---

## 5. Configuración del Pipeline de CI en Jenkins

Para conectar este repositorio a Jenkins y ejecutar las pruebas automáticamente:

1. En el panel principal de Jenkins, haz clic en **New Item** (Nueva Tarea).
2. Escribe el nombre: `SIGA-Pipeline`.
3. Selecciona el tipo **Pipeline** y haz clic en **OK**.
4. En la sección **Pipeline** (al final de la página):
   - **Definition**: Selecciona `Pipeline script from SCM`.
   - **SCM**: Elige `Git`.
   - **Repository URL**: `https://github.com/danilohm1988/SIGA-Configuracion.git`
   - **Branch Specifier**: `*/develop` (o `*/main`).
   - **Script Path**: `Jenkinsfile`.
5. Haz clic en **Save** (Guardar).
6. Presiona **Build Now** (Construir ahora) para ejecutar el pipeline.
7. Haz clic sobre el número del build (ej. `#1`) y luego en **Console Output** para ver la ejecución paso a paso en tiempo real.

---

## 6. Estrategia de Ramas (Git Flow)

Seguimos las reglas definidas para el proyecto:

| Rama | Propósito | Regla de Oro |
| :--- | :--- | :--- |
| `main` | Código de producción estable | Solo recibe fusiones de `release/*` y `hotfix/*`. |
| `develop` | Rama principal de desarrollo | Nace de `main`. Punto de partida de nuevas features. |
| `feature/*` | Nuevas funcionalidades aisladas | Nace de `develop` y se integra con Pull Request (PR). |
| `release/*` | Estabilización para lanzamiento | Nace de `develop` y se etiqueta con un Tag formal. |
| `hotfix/*` | Corrección urgente en producción | Nace directo de `main` y se fusiona en `main` y `develop`. |

### Convención de Commits
Formato estándar: `tipo(ámbito): descripción breve en imperativo`
- `feat(estudiantes): habilitar registro de matrícula`
- `fix(core): corregir conflicto de títulos en index.html`
- `chore(jenkins): configurar pipeline declarativo`

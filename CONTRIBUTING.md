# Guía de Contribución - Proyecto SIGA

¡Bienvenidos al proyecto **SIGA**! Para mantener un control de versiones limpio, reproducible y auditable bajo la estrategia **Git Flow**, todos los integrantes (**Daniel, Cesar y Eddi**) deben seguir estas pautas.

---

## 1. Estrategia de Ramas (Git Flow)

- `main`: Código de producción estable. Prohibido hacer `git push` directo.
- `develop`: Rama base de desarrollo donde se integran los incrementos.
- `feature/<nombre-modulo>`: Para nuevas funcionalidades. Nace siempre de `develop`.
- `release/<version>`: Para preparación y estabilización de una nueva versión formal (ej. `release/v1.1.0`).
- `hotfix/<nombre-error>`: Para correcciones urgentes directamente en producción. Nace de `main` y se fusiona tanto en `main` como en `develop`.

---

## 2. Convención de Commits

Utilizamos el estándar de **Conventional Commits**:

```text
tipo(ámbito): descripción breve en modo imperativo
```

### Tipos permitidos:
- `feat`: Nueva funcionalidad o módulo (ej. `feat(materias): agregar vista de asignaturas`).
- `fix`: Corrección de errores o solución de conflictos (ej. `fix(core): corregir titulo en index.html`).
- `docs`: Modificaciones en documentación (ej. `docs: actualizar guia de instalacion`).
- `chore`: Tareas de mantenimiento o configuración (ej. `chore(deps): actualizar dependencias`).
- `ci`: Cambios en la automatización o pipelines (ej. `ci(jenkins): agregar etapa de validacion`).

---

## 3. Procedimiento para Pull Requests (PR)

Antes de fusionar cualquier rama hacia `develop` o `main`:

1. **Crear la rama:** `git checkout -b feature/<modulo> develop`
2. **Probar localmente:** Verificar que `index.html` y los scripts funcionen sin errores.
3. **Subir la rama:** `git push -u origin feature/<modulo>`
4. **Abrir el Pull Request en GitHub:**
   - **Objetivo:** ¿Qué problema resuelve este cambio?
   - **Cambios realizados:** Lista detallada de archivos modificados.
   - **Pruebas realizadas:** Evidencia de pruebas manuales o automatizadas.
   - **Checklist:**
     - [ ] Código sin conflictos con `develop`.
     - [ ] Commits descriptivos según la convención.
     - [ ] Revisión y aprobación de al menos otro integrante del equipo.

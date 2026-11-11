# choosing-a-model

Skill para agentes (formato `SKILL.md`) que ayuda a elegir el modelo Claude, el nivel de `effort` y la delegación a subagentes, siguiendo la guía oficial de Anthropic:
https://platform.claude.com/docs/en/about-claude/models/choosing-a-model

A skill for coding agents (`SKILL.md` format) that recommends a Claude model, effort level and orchestrator/subagent split, based on Anthropic's official guide.

## Estructura / Layout

- `choosing-a-model/SKILL.md`: las reglas (portable).
- `choosing-a-model/references/models.md`: datos de modelos, con fuente y fecha de última verificación.
- `agents/`: subagentes opcionales solo para Claude Code (ver `agents/README.md`).
- `examples/cases.md`: casos de prueba manuales (qué debe y qué no debe responder la skill).

## Uso / Usage

- **Claude Code / agentes con skills:** copia la carpeta `choosing-a-model/` (con `references/`) a tu carpeta de skills y pregunta, por ejemplo, "¿qué modelo uso para este agente?".
- **Chatbot normal:** pega `choosing-a-model/SKILL.md` y `references/models.md` en el chat o en un prompt de sistema.

## Mantenimiento / Maintenance

- Los datos de modelos cambian. Cada entrada de `references/models.md` lleva su fuente y la fecha de verificación; la skill pide revisar la fuente si tiene más de 30 días.
- Una GitHub Action (`.github/workflows/check-source.yml`) compara cada mes el hash de la guía oficial con `snapshot/guide.sha256` y abre un issue si cambió. Solo detecta: actualizar `references/models.md` y la fecha es revisión humana. Después se corre `bash scripts/check_source.sh update` y se hace commit.
- La guía oficial no detalla reglas de subagentes; la sección de heurísticas está marcada como criterio del autor.
- Proyecto no oficial, no afiliado a Anthropic.

## Licencia

MIT

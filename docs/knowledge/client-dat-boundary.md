# Client DAT Boundary

Status: starter note
Last updated: 2026-03-15
Domains: documentation, client-dat, server-core

## Purpose

Keep server-enforced behavior separate from client, DAT, UI, launcher, or bootloader behavior during investigations and design work.

## Inspected

- `grounding.md`
- repo root directory layout

## Confirmed

- LandSandBoat is a server-side project.
- DAT, UI, launcher, and bootloader work are client-side concerns unless proven otherwise.
- DAT-related tasks must always separate server-side responsibilities from client-side responsibilities.
- DAT questions require an explicit statement of what is server-side, what is client-side, whether both sides need changes, and how to validate the result in game.
- No dedicated client-DAT workspace was identified in the scanned top-level repo tree.

## Inferred

- Some user-reported UI or visual issues may require client changes even when the server also gates the behavior.

## Unknown

- Where this project stores lawful client-side modifications, if anywhere.
- Which gameplay rules in this private server are enforced only by packets or server logic versus rendered purely by client DAT data.

## Risk

- Mixing server truth with client truth leads to wrong fixes and misleading explanations.

## Next Verification Step

- For the first DAT-related task, produce a two-track note that lists the server files, the client files or external workspace, and the in-game validation path.

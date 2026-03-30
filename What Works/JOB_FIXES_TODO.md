# Job Fixes Implementation Tracker

## Completed
- [x] GEO Collimated Fervor — ability routing script created
- [x] PLD Guardian — already implemented (audit was wrong)
- [x] GEO Concentric Pulse, Mending Halation, Radial Arcana — already implemented
- [x] RUN Runeist Bandeau +1 (27787) — mods added (16 stats)
- [x] RUN Runeist Mitons +1 (28067) — mods added (16 stats)

## In Progress

### SCH AF3: Seeing Blood-red
- **Research**: Complete (see Research/phase2/base_game/quests/sch_af3_research.md)
- **Quest ID**: crystalWar quest 34
- **Reward**: Scholar's Mortarboard (16140) — item + mods exist
- **Erlene events**: Unused from AF1/AF2: 10, 11, 12, 13, 14, 29, 31, 32, 34
- **Likely AF3 events**: 29, 31, 32, 34 (need in-game verification with !cs)
- **Files to create**:
  - [ ] scripts/quests/crystalWar/SCH_AF3_Seeing_Blood_Red.lua
  - [ ] scripts/zones/Ruhotz_Silvermines/instances/seeing_blood_red.lua
  - [ ] scripts/zones/Ruhotz_Silvermines/mobs/Ulbrecht.lua
- **Files to modify**:
  - [ ] Erlene NPC in The_Eldieme_Necropolis_[S] (add AF3 handlers)
  - [ ] Indescript_Markings in Pashhow_Marshlands_[S] (add letter pickup)
  - [ ] Ruhotz_Silvermines/IDs.lua (add Ulbrecht mob reference)
- **Blockers**: Need to verify event CSIDs via !cs testing at Erlene
- **Mob data**: Ulbrecht pool 4078, group 4659, zone 93, Lv67, ~12k HP, Tabula Rasa at 50%

### PUP AF3: Puppetmaster Blues
- **Research**: Complete (see Research/phase2/base_game/quests/pup_af3_research.md)
- **Quest ID**: ahtUrhgan quest 29, battlefield ID 1090
- **Reward**: Puppetry Taj (15267) — item + mods exist
- **Files to create**:
  - [ ] scripts/battlefields/Talacca_Cove/puppetmaster_blues.lua
  - [ ] scripts/zones/Talacca_Cove/mobs/Valkeng.lua (frame-switching AI)
- **Files to modify**:
  - [ ] Iruki-Waraki NPC (add AF3 start/progress/complete)
  - [ ] Sajhra in Nashmau (add AF3 cutscene)
  - [ ] Talacca_Cove/IDs.lua (add Valkeng reference)
- **Note**: Even with AF3, PUP only gets 3/5 AF. Body/hands/feet need commission system.

### RUN AF Quests 2-5
- **Research**: Complete (see Research/phase2/base_game/quests/run_geo_af_scope.md)
- **Quests**: 4 quests across Adoulin/Ulbuka zones
- **Needs**: 4 quest scripts + 3-4 NMs + NPC scripts
- **No SoA mission prereqs** — only Adoulin Fame 1 + prior quest

### GEO AF Quests 2-5
- **Research**: Complete (see Research/phase2/base_game/quests/run_geo_af_scope.md)
- **Quests**: 4 quests across Adoulin/Ulbuka zones
- **Needs**: 4 quest scripts + 3 NMs + NPC scripts
- **Potential blocker**: Cirdas Caverns access may need Colonization Reive

### PUP Commission System (Dhima Polevhia)
- **Needed for**: PUP body/hands/feet AF pieces
- **Also used by**: RUN + GEO for their remaining 3 AF pieces each
- **Shared framework**: Commission NPC that crafts AF for materials + time

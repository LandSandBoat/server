# Trusts (Alter Egos)
## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Trust
- Codebase:
  - `scripts/globals/trust.lua` — core trust framework (canCast, spawn, cipher trading, KI checks)
  - `scripts/actions/spells/trust/` — 120 individual trust spell scripts
  - `src/map/utils/trustutils.cpp` — C++ trust spawning, stat/skill calculation
  - `src/map/ai/controllers/trust_controller.cpp` — trust AI controller
  - `src/map/ai/helpers/gambits_container.cpp` — gambit (AI behavior) system
  - `settings/default/main.lua` lines 168-176 — trust settings
  - `scripts/quests/bastok/Trust_Bastok.lua` — Bastok trust permit quest
  - `scripts/quests/hiddenQuests/Trust_*.lua` — 12 hidden trust acquisition quests
  - `scripts/globals/extravaganza.lua` — Alter Ego Extravaganza campaign (currently disabled)
  - `scripts/globals/roe_records.lua` — ROE trust objectives (records 932-936)

## Summary
The trust system is well-implemented with 120 trust spell scripts (retail has 119 available). The core framework for summoning, party limits, cipher trading, and Rhapsody KI bonuses is fully functional. However, 71 of 120 trusts have no AI gambits, meaning they will auto-attack but not use spells/abilities intelligently. The Alter Ego Extravaganza campaign is hard-disabled in code. Iroha and Iroha II scripts exist but have zero combat AI.

## Checklist
| Item | Status | Notes |
|------|--------|-------|
| Trust summoning framework | WORKS | `xi.trust.canCast` validates all conditions: permit, party size, zone type, enmity, alliance, seeking party, battlefield restrictions |
| Trust casting setting | WORKS | `ENABLE_TRUST_CASTING = 1` in `settings/default/main.lua` |
| Trust permit quests | WORKS | Bastok (`Trust_Bastok.lua`), San d'Oria (via `Excenmille.lua` NPC), Windurst (via `Kupipi.lua` NPC) all grant permits. Requires level 5+ |
| Nation trusts (quest rewards) | WORKS | Bastok gives Naji/Ayame/Volker/Iron Eater via quest chain. San d'Oria gives Excenmille/Curilla/Trion. Windurst gives Kupipi/Nanaa Mihgo/Ajido-Marujido |
| Cipher item trading | WORKS | Three cipher NPCs: Clarion Star (Port Bastok), Gondebaud (S. San d'Oria), Wetata (Windurst Woods). Items 10112-10193 (82 ciphers in SQL). Cipher subId encodes spellId + flags |
| Hidden quest trusts | WORKS | 12 hidden quests: Shantotto (requires all 9 nation trusts + quest), Cherukiki, Halver, Ingrid, Maat, Nashmeira, Prishe, Semih Lafihna, ShikareeZ, Ulmia, Zeid II, Abquhbah |
| ROE trust objectives | WORKS | Record 932: "Call Forth an Alter Ego" gives Cipher: Valaineral. Records 933-936 chain: Valaineral->Mihli->Tenzen->Adelheid->Joachim |
| Alter Ego Extravaganza | MISSING | Hard-disabled in `extravaganza.lua` line 24: always returns `NONE`. Comment says "NPCs are currently not present in the client" |
| Login campaign trusts | MISSING | `ENABLE_TRUST_ALTER_EGO_EXTRAVAGANZA = 0` by default; even if enabled, code force-returns NONE |
| Trust count limit (base) | WORKS | Default max 3 trusts. Checked via party size cap of 6 |
| Rhapsody in White bonus (+1 trust) | WORKS | KI 2884 allows 4th trust (line 383 of trust.lua) |
| Rhapsody in Crimson bonus (+1 trust) | WORKS | KI 2887 allows 5th trust (line 386 of trust.lua) |
| Trusts in battlefields | WORKS | Rhapsody in Umber (KI) enables trusts in LB5 fights and other battlefields. `allowTrusts` flag per battlefield |
| Valaineral (PLD tank) | WORKS | Full gambit AI: Provoke, Flash, Sentinel, emergency Cure. Solid tank trust |
| Kupipi (WHM healer) | WORKS | Extensive gambit AI: Cure priority, status removal (Poisona/Paralyna/Blindna/Silena/Stona/Viruna/Cursna), Erase, Protectra, Shellra, Paralyze/Slow/Flash on target. Well-implemented |
| Shantotto (BLM damage) | WORKS | Gambit AI: Magic Burst when available, highest-tier nuke when no SC available. Has MATT/MACC/Haste mods. Auto-attack disabled. Proper caster |
| Shantotto II | WORKS | Similar to Shantotto with MB + nuke gambits. Blocks summoning alongside Shantotto I |
| Iroha (ROV trust) | PARTIAL | Script exists, spawns correctly, has teamwork exclusion with Iroha II. **No AI gambits** -- will only auto-attack, no WS or abilities |
| Iroha II (ROV trust) | PARTIAL | Same as Iroha -- script exists but **no AI gambits**. Just auto-attacks |
| August (SoA tank) | PARTIAL | Has mob skill attack and TP skill settings but **no AI gambits** for tanking abilities (no Provoke, no Flash, no defensive cooldowns) |
| D.Shantotto | PARTIAL | Script exists, **no AI gambits**. Will only auto-attack despite being a mage trust |
| Monberaux | WORKS | Extremely detailed gambit AI with Mix abilities, Guard Drink, status healing, item donation system. One of the most complete trust scripts |
| Matsui-P | MISSING | Not implemented (retail-exclusive trust, not in LandSandBoat) |
| Trust stat scaling | WORKS | Trusts match master's main level. Stats calculated from job grades + family ranks. Configurable multipliers: `ALTER_EGO_HP_MULTIPLIER`, `ALTER_EGO_MP_MULTIPLIER`, `ALTER_EGO_STAT_MULTIPLIER`, `ALTER_EGO_SKILL_MULTIPLIER` |
| Trust AI (gambit system) | PARTIAL | 49 of 120 trusts have gambit-based AI. 71 trusts have no gambits (spawn message + auto-attack only) |
| Trust iLvl scaling | MISSING | No iLvl concept for trusts. Level capped at master's level (max 99 for skill calculations). Trusts do not gain power from player iLvl gear |
| Duplicate trust blocking | WORKS | Cannot summon same trust twice. Variant blocking works (Shantotto I blocks II, Iroha I blocks II, etc.) |
| Trust zone restrictions | WORKS | Uses `xi.zoneMisc.TRUST` flag per zone. Trusts blocked in alliances, while seeking party, and for 120s after new party member joins |

## Trust Script Count
- **Total trust spell scripts:** 120
- **Retail trust count:** 119 (per bg-wiki)
- **Trusts with AI gambits:** 49 (41%)
- **Trusts with NO gambits (auto-attack only):** 71 (59%)

### Notable trusts WITHOUT AI gambits (will only auto-attack):
- Iroha, Iroha II (ROV protagonist trusts)
- D.Shantotto (should be a BLM caster)
- August (should be a PLD/tank - has TP skill but no Provoke/Flash)
- Aldo, Arciela, Arciela II, Balamor, Brygid, Cid, Darrcuiln, Elivira, Excenmille [S], Gilgamesh, Halver, Ingrid, Ingrid II, Kayeel-Payeel, King of Hearts, Klara, Kukki-Chebukki, Kupofried, Kuyin Hathdenna, Leonoyne, Lhe Lhangavo, Lilisette, Lilisette II, Lion II, Luzaf, Makki-Chebukki, Margret, Maximilian, Mayakov, Mildaurion, Mnejing, Moogle, Morimar, Mumor II, Najelith, Nashmeira, Noillurie, Ovjang, Robel-Akbel, Romaa Mihgo, Rongelouts, Rosulatia, Rughadjeen (partial - listed with gambits but tank behavior incomplete), Sakura, Selh'teus, Star Sibyl, Teodor, Tenzen II (has 1 gambit), Ullegore, Ygnas, Zazarg, Zeid, plus all 5 Ark Angels (AAEV, AAGK, AAHM, AAMR, AATT)

## Trust Acquisition Methods Summary
1. **Trust Permit Quests** (3 nations) -- level 5 required, talk to Clarion Star / Gondebaud / Wetata
2. **Nation NPC chains** -- talk to NPCs after permit quest to learn nation trusts
3. **Hidden Quests** (12) -- specific prerequisites like completing all nation trusts, expansion missions
4. **Cipher Items** (82 in database) -- trade to permit NPCs, items 10112-10193
5. **ROE Records** (chain of 5) -- records 932-936 give ciphers for Valaineral, Mihli, Tenzen, Adelheid, Joachim
6. **Alter Ego Extravaganza** -- DISABLED (code returns NONE regardless of settings)

## Blockers
- 71 trusts with no AI gambits are functionally impaired -- they auto-attack but do not use job abilities, weapon skills, or magic. This is especially problematic for caster/healer trusts that should not be meleeing.
- Alter Ego Extravaganza is hard-disabled, blocking access to some trust ciphers that are only available during that event (e.g., the [S] era NPC ciphers: Noillurie, Leonoyne, Elivira, Maximilian, Lhu Mhakaracca, Kayeel-Payeel).
- No iLvl scaling means trusts become progressively weaker relative to content above level 99.
- Iroha and Iroha II (key ROV trusts) have no combat AI despite being among the most important trusts for solo play.

## Fix Difficulty
- Easy: Enable Alter Ego Extravaganza via settings (but comment says client NPCs may be missing)
- Medium: Add AI gambits to the ~20 most important trusts lacking them (Iroha, Iroha II, D.Shantotto, August, Zeid, Lilisette, etc.)
- Hard: Implement AI gambits for all 71 missing trusts
- Massive: Implement iLvl scaling for trusts (would require C++ changes to trustutils.cpp)

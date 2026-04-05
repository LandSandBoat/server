# Trust Recommendations by Player Job

All 120 trusts have gambits. These recommendations are based on what each trust
actually does in their Lua scripts, matched to what each player job needs.

Tank trusts all have a 1.5x ATT boost (`math.floor(mob:getMainLvl() * 1.5)`).

---

## Paladin (you tank, you have Cure/Protect/Shell/Flash)

You need: Haste (can't self-cast), Refresh (MP hungry), DPS (you do low damage)

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **Arciela** | Only healer trust with both Haste AND Refresh gambits — exactly what PLD needs for MP |
| 2 | **Monberaux** | Guard Drink (Protect+Shell stack), Regen, STR boost, Ether at <50% MP, widest status removal |
| 3 | **Joachim** | March/Madrigal speed up party kills, Ballad helps MP, Elegy on mob |
| 4 | **Zeid II** | Stun on casting/readying protects you, Last Resort/Souleater for damage |
| 5 | **Ayame** | Hasso/Third Eye/Meditate — fully self-sufficient DPS, no support overlap |

## Rune Fencer (you tank, you have Regen/Phalanx/resist magic)

You need: Haste, less MP support than PLD, raw DPS

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **Ferreous Coffin** | Haste on all, Raise III safety net, Refresh II passive, prioritizes status removal on highest enmity (you) |
| 2 | **Cherukiki** | Regen +5/tick stacks with your Regen, Haste on you, Protect/Shell, Silence on mob |
| 3 | **Joachim** | March/Madrigal/Elegy + backup cure + full status removal |
| 4 | **Gilgamesh** | Hasso/Third Eye/Meditate, pure melee — WS at 1000 TP ASAP |
| 5 | **Lion** | 4 interrupt gambits (Grapeshot stun on WS/MS/JA/casting) — supplements your Stun |

## Warrior (you tank or DPS, you have Berserk/Aggressor/Defender/Provoke)

You need: Healer, Haste, and trusts that don't duplicate your JAs

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **August** | You go full Berserk/Aggressor while August holds hate with Provoke/Flash/Sentinel/Defender/Rampart/Palisade |
| 2 | **Karaha-Baruha** | Haste, adaptive Bar-element spells on elemental damage, wide curse removal, heals at 55% |
| 3 | **Koru-Moru** | Phalanx II on August, Refresh on casters, Haste backup, Slow/Distract debuffs |
| 4 | **Mumor** | Haste Samba + Stutter Step debuff + Violent Flourish interrupts on 4 triggers, Saber Dance |
| 5 | **Tenzen** | Hasso/Third Eye/Meditate, holds WS to 1500 TP for bigger hits |

## Samurai (you DPS, you have Hasso/Meditate/Third Eye)

You need: Tank, healer, attack buffs — trusts with Hasso/Meditate are wasted on you

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **Rahal** | Tank with Shield Bash interrupt, Enlight, Phalanx self-buff, AND casts Berserk on YOU — only tank that buffs the player |
| 2 | **Apururu UC** | Haste on melee (you), full status removal, Convert for sustain |
| 3 | **Joachim** | March/Madrigal directly boost your melee DPS and accuracy |
| 4 | **Arciela II** | Slow/Paralyze/Dispel on mob, weakness-targeting nukes for extra damage |
| 5 | **Uka Totlihn** | Quickstep debuff, Violent Flourish interrupts, Curing Waltz backup heals, Drain Samba |

## Dark Knight (you DPS, you have Stun/Last Resort/Souleater/Drain/Aspir)

You need: Tank, healer, buffs — interrupt trusts less important since you have Stun

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **August** | Full tank suite, Souleater generates massive enmity so you need August's aggressive Provoke spam |
| 2 | **Ferreous Coffin** | Haste on all, Raise III (DRK dies from Souleater), status removal on top enmity |
| 3 | **King of Hearts** | Haste on melee, Refresh on casters, Phalanx II on August, Dispel, Dia, AND 40% chance Firaga for extra DPS |
| 4 | **Joachim** | March/Madrigal for your melee, Elegy on mob |
| 5 | **Prishe II** | Pure MNK DPS + emergency Curaga at <25% party HP safety net |

## Monk (you DPS, you have Chakra/Focus/Dodge/Counterstance)

You need: Tank, healer, Haste, attack buffs

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **August** | Tank |
| 2 | **Yoran-Oran UC** | +50 Cure Potency, Stoneskin, Afflatus Solace, full status removal — strongest raw healer |
| 3 | **Koru-Moru** | Haste on you, Phalanx II on August, Slow/Distract debuffs on mob |
| 4 | **Joachim** | March/Madrigal boost your multi-hit attacks |
| 5 | **Volker** | Smart AI — detects August is tanking, switches to Berserk/Aggressor DPS mode automatically |

## Thief (you DPS, you have SA/TA/Flee)

You need: Tank for Trick Attack positioning, Haste, debuffs

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **August** | Stable tank — TA requires standing behind mob relative to tank, August's aggressive enmity holds position |
| 2 | **Apururu UC** | Haste on melee (you), full status removal, Convert |
| 3 | **Arciela II** | Slow/Paralyze/Dispel on mob + Haste/Refresh on party + nukes |
| 4 | **Maximilian** | Also uses SA/TA constantly — two thieves do more positional damage than one thief + generic DPS |
| 5 | **Mumor** | Haste Samba, Stutter Step DEF debuff, Violent Flourish interrupts |

## Dragoon (you DPS, you have Jump/High Jump/Spirit Surge)

You need: Tank, healer, Haste, straightforward support

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **Halver** | Solid tank (Provoke/Flash/Shield Bash/Sentinel/Rampart), cure at 40% |
| 2 | **Karaha-Baruha** | Haste, bar-element reactive casting, Protect/Shell, wide status removal |
| 3 | **Koru-Moru** | Phalanx II on Halver, Haste/Refresh, Slow/Distract on mob |
| 4 | **Uka Totlihn** | Quickstep + Violent Flourish interrupts protect your long Jump animations |
| 5 | **Gilgamesh** | Self-sufficient SAM DPS (Hasso/Third Eye/Meditate), no support overlap |

## Ranger/Corsair (you ranged DPS)

You need: Tank, healer, melee DPS to fill gap, Flurry

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **Rughadjeen** | Tank with 75% cure threshold + sleep wake — high healing output frees healer slot |
| 2 | **Koru-Moru** | Casts FLURRY on ranged (you!) — only trust that does this. Plus Haste on melee, Refresh, debuffs |
| 3 | **Joachim** | Madrigal for accuracy, March for speed, Elegy |
| 4 | **Zeid II** | Melee DPS + 4 stun interrupts |
| 5 | **Ayame** | Self-sufficient SAM DPS |

## Black Mage (you nuke, you have Elemental Seal/Manafont)

You need: Tank, Refresh (critical), Ballad, MP support

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **August** | Tank |
| 2 | **Arciela** | Haste + Refresh on you — Refresh is life for BLM |
| 3 | **Koru-Moru** | Refresh on casters (you!), Haste backup, debuffs reduce mob magic resist |
| 4 | **Joachim** | Ballad = MP regen song stacks with Refresh, March on melee trusts |
| 5 | **Zeid II** | Melee DPS + Stun covers you while casting |

## White Mage (you heal, you have Cure/Protect/Shell/Haste/status removal)

You need: Tank, Refresh, DPS — healing trusts are wasted

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **August** | Tank |
| 2 | **Arciela II** | Slow/Paralyze/Dispel debuffs + nukes — no healing overlap with you |
| 3 | **Joachim** | Ballad for your MP, March on melee, Elegy |
| 4 | **Zeid II** | DPS + stun interrupts reduce healing pressure on you |
| 5 | **Volker** | Auto-DPS mode with August tanking (Berserk/Aggressor) |

## Red Mage (you support, you have Haste/Refresh/debuffs/Convert)

You need: Tank, healer, pure DPS — support trusts duplicate you

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **August** | Tank |
| 2 | **Yoran-Oran UC** | Healer with +50 Cure Potency, Stoneskin — you handle buffs, he handles heals |
| 3 | **Gilgamesh** | Self-sufficient melee DPS |
| 4 | **Zeid II** | DPS + stuns |
| 5 | **Shantotto II** | Magic burst + nukes with 45s cooldown — you make skillchains, she bursts |

## Bard (you buff, you have March/Madrigal/Ballad/Minuet)

You need: Tank, healer, pure DPS — bard trusts are wasted

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **August** | Tank |
| 2 | **Karaha-Baruha** | Healer with Haste + bar-element — doesn't overlap with your songs |
| 3 | **Zeid II** | DPS + stuns |
| 4 | **Ayame** | Self-sufficient SAM DPS |
| 5 | **Uka Totlihn** | Quickstep/Violent Flourish + Drain Samba — dancer utility stacks with your songs |

## Scholar (you nuke/heal hybrid, you have Sublimation/Stratagems/Storm)

You need: Tank, DPS — you're self-sufficient on MP

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **August** | Tank |
| 2 | **Adelheid** | SCH trust with Dark Arts/Addendum Black, Stun on 4 triggers, Storm/Helix matching day, cures tank at <50% |
| 3 | **Joachim** | Ballad for MP, March on melee |
| 4 | **Gilgamesh** | Pure melee DPS |
| 5 | **Lion** | 4 interrupt gambits — between you, Adelheid, and Lion, nothing casts |

## Geomancer (you support, you have Indi/Geo bubbles)

You need: Tank, healer, DPS

| Slot | Trust | Why |
|------|-------|-----|
| 1 | **Halver** | Solid tank |
| 2 | **Ferreous Coffin** | Haste on all, Raise III, Refresh II passive, status removal |
| 3 | **Zeid II** | DPS + stuns |
| 4 | **Ayame** | Self-sufficient SAM DPS |
| 5 | **Prishe II** | MNK DPS + emergency Curaga safety net |

---

## Notable Trust Interactions

- **Rahal** casts Berserk on the player — only tank that directly buffs you
- **Volker** auto-switches to DPS mode when another tank is present
- **Koru-Moru** casts Flurry on ranged jobs — only trust that does this
- **Ferreous Coffin** prioritizes status removal on highest enmity — perfect for tanks
- **Arciela** (not II) is the only healer trust with a Refresh gambit
- **Mumor + Uka Totlihn** have synergy bonuses when both summoned (+10 samba duration / +10 waltz potency)
- **Adelheid** is a proper SCH with Dark Arts/Addendum Black, day-matching Storm/Helix
- **Maximilian** uses SA/TA constantly — pair with THF for double positional damage

## Tank Trust Tier List

| Tier | Trust | Key Abilities |
|------|-------|---------------|
| S | **August** | Provoke/Flash/Shield Bash always, Sentinel <50%, Defender <60%, Rampart/Palisade/Warcry |
| S | **Rahal** | Flash, Provoke, Sentinel <33%, Shield Bash interrupt on casting/readying, Enlight, Phalanx, Berserk on player |
| A | **Rughadjeen** | Sentinel, Flash, Divine Emblem, Holy (undead), cure at 75%, sleep wake, FastCast +30, DMG -5%, Triple Attack +3 |
| A | **Halver** | Provoke/Flash/Shield Bash, Sentinel <50%, Rampart |
| B | **AAEV** | Provoke/Flash, Sentinel <50%, Rampart |
| B | **Gessho** | NIN evasion tank — Utsusemi/Kurayami/Hojo/Yonin/Provoke, no cures |
| B | **Mildaurion** | Provoke, Sentinel <50%, Rampart, skillchain opener, +100% MP |
| C | **Valaineral** | Provoke (enmity check), Flash, Sentinel, cure at 50% |
| C | **Trion** | Provoke (enmity check), Flash, cure at 75% |
| C | **Curilla** | Sentinel, Flash, cure at 75% — no Provoke |
| C | **Excenmille** | Sentinel, Flash, cure at 75%, Store TP +25 |

## Healer Trust Tier List

| Tier | Trust | Key Features |
|------|-------|-------------|
| S | **Apururu UC** | Cure <25%/<75%, Haste on melee, full status removal (7 types), Convert <25% MP, Stoneskin, Erase |
| S | **Yoran-Oran UC** | Cure <25%/<75%, +50 Cure Potency, Afflatus Solace, Stoneskin, full status removal, Erase |
| S | **Monberaux** | Mix system — Guard Drink, potions, widest status removal, Regen/STR/MDEF buffs, Ether on casters |
| A | **Ferreous Coffin** | Haste on all, Raise III, Refresh II passive, status removal on top enmity, Erase |
| A | **Karaha-Baruha** | Cure <55%, Haste, adaptive Bar-element on damage, Protect/Shell, wide curse removal |
| A | **Kupipi** | Cure <25%/<75%, full status removal, Erase, Flash, Paralyze/Slow on mob |
| B | **Mihli Aliapoh** | Cure <25%/<75%, Afflatus Solace, full status removal, Erase, Paralyze/Slow |
| B | **Arciela** | Cure <40%/<75%, Haste, Refresh, Protect/Shell, Slow/Paralyze — only healer with Refresh |
| B | **Cherukiki** | Cure <25%/<75%, Regen +5/tick, Haste on master+melee, Protect/Shell, Paralyze/Slow/Silence |
| B | **Nashmeira II** | Cure <75%, Curaga <50% (AoE), full status removal, Erase |

## Support Trust Tier List

| Tier | Trust | Key Features |
|------|-------|-------------|
| S | **Koru-Moru** | Convert, Protect/Shell, Haste on melee, Refresh on casters+tanks, Flurry on ranged, Phalanx II on tank, Dispel, Dia/Slow/Distract |
| S | **King of Hearts** | Cure <50%, Protect/Shell, Haste on melee, Refresh on casters, Phalanx II on tank, Dispel, Dia, Firaga 40% |
| A | **Arciela II** | Convert <20%, Haste/Refresh on party, Slow/Paralyze/Dispel, weakness nukes 60%, Stone 40% |
| A | **Adelheid** | Dark Arts/Addendum Black, Stun on 4 triggers, day-matching Storm/Helix, cure tank <50%, cure party <33% |
| B | **Qultada** | Corsair's Roll + Chaos Roll + ranged DPS |

## DPS Trust Tier List

| Tier | Trust | Key Features |
|------|-------|-------------|
| S | **Zeid II** | Stun on 4 triggers (WS/MS/JA/casting), Last Resort, Souleater |
| S | **Shantotto II** | Magic burst + highest nuke (45s cooldown), Final Exam WS at 2500 TP |
| A | **Ayame** | Hasso/Third Eye/Meditate, opener WS rotation |
| A | **Gilgamesh** | Hasso/Third Eye/Meditate, WS at 1000 ASAP |
| A | **Iroha II** | Hasso/Third Eye/Meditate, Protect/Shell on party |
| A | **Volker** | Smart AI — tank or DPS mode based on party comp, Berserk/Aggressor in DPS mode |
| A | **Uka Totlihn** | Quickstep/Violent Flourish interrupts, Haste Samba, Curing Waltz, Drain Samba, Mumor synergy |
| B | **Tenzen** | Hasso/Third Eye/Meditate, WS at 1500 |
| B | **Lion** | 4 Grapeshot stun interrupts, Utsusemi |
| B | **Mumor** | Saber Dance, Stutter Step, Violent Flourish interrupts, Haste Samba |
| B | **Prishe II** | MNK DPS + emergency Curaga <25%, Psycho Anima |
| B | **Maximilian** | Constant SA/TA — positional damage |
| C | **D.Shantotto** | MB + BEST_AGAINST_TARGET nuke |
| C | **Robel-Akbel** | MB + Stun on casting + BEST_AGAINST_TARGET |
| C | **Teodor** | MB + BEST_AGAINST_TARGET |
| C | **Kayeel-Payeel** | MB + BEST_AGAINST_TARGET |

## Bard/Song Trust Tier List

| Tier | Trust | Songs | Secondary |
|------|-------|-------|-----------|
| S | **Joachim** | March, Madrigal, Ballad, Elegy, Paeon | Full status removal (7 types), cure <50% |
| C | **Ulmia** | Madrigal, Minuet | Needs major overhaul (flagged in code) |

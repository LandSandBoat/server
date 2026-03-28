# Server Implementation Audit Plan

## Goal
Comprehensive audit of what actually works end-to-end from a player's perspective. Not "does the code exist" but "can a player actually do this from start to finish without GM intervention."

## Multi-Agent Design
This audit will be done in small batches across multiple sessions. Any agent picking this up should:
1. Read this file first for methodology and status key
2. Read `PROGRESS.md` for what's been done and what's next
3. Pick up the next unresearched section from the queue in PROGRESS.md
4. Write findings to small, focused MD files in the folder structure below
5. Update PROGRESS.md when done with a batch

Each research batch should cover ONE small topic (e.g., "Bastok Rank 1-3 missions" or "Rune Fencer unlock"). Never try to research more than 2-3 files in a single batch.

## Methodology
For each item, check the codebase AND cross-reference with bg-wiki.com to confirm retail behavior.

**Codebase checks:**
- Script exists? (`scripts/missions/`, `scripts/quests/`, `scripts/zones/*/npcs/`)
- NPC exists in DB? (`sql/npc_list.sql`)
- Zone accessible? (`sql/zone_settings.sql`, transport scripts)
- Items/KIs defined? (`scripts/enum/key_item.lua`, `scripts/enum/item.lua`)
- Mob data exists? (`sql/mob_pools.sql`, `sql/mob_spawn_points.sql`)

**bg-wiki cross-reference:**
- What should this quest/system do on retail?
- What NPCs/zones/items are involved?
- What are the prerequisites?

## Status Key
- WORKS — Fully functional end-to-end, tested or code-verified
- PARTIAL — Some parts work, details noted
- STUB — Code exists but auto-completes or skips content
- MISSING — No implementation at all
- BLOCKED — Depends on broken prerequisite (note what)
- WORKAROUND — Needs GM commands (document them)

## File Format
Every research file should follow this template:
```markdown
# [Topic Name]
## Source
- bg-wiki: [url]
- Codebase: [key file paths checked]

## Summary
[1-2 sentence overview of status]

## Checklist
| Item | Status | Notes |
|------|--------|-------|
| Step/quest/feature | WORKS/PARTIAL/etc | details |

## Blockers
- [anything that prevents this from working]

## Fix Difficulty
- Easy / Medium / Hard / Massive
```

---

## Folder Structure

```
what works/
  AUDIT_PLAN.md        ← this file (methodology, status key, file format)
  PROGRESS.md          ← tracks what's researched, what's next, queue
  Research/
    00_core/
      combat.md
      skillchains_magic_bursts.md
      transport.md
      trusts.md
      roe.md
      mog_house.md
      auction_house.md
      sparks_vendor.md
      currencies.md
      jobs/
        war.md, mnk.md, whm.md, blm.md, rdm.md, thf.md
        pld.md, drk.md, bst.md, brd.md, rng.md, sam.md
        nin.md, drg.md, smn.md
        blu.md, cor.md, pup.md
        dnc.md, sch.md
        run.md, geo.md
      crafting/
        woodworking.md, smithing.md, goldsmithing.md
        clothcraft.md, leathercraft.md, bonecraft.md
        alchemy.md, cooking.md, fishing.md
    01_base_game/
      sandoria/
        missions_rank1-3.md
        missions_rank4-6.md
        missions_rank7-10.md
        quests_starter.md
        quests_fame.md
        quests_other.md
      bastok/
        missions_rank1-3.md
        missions_rank4-6.md
        missions_rank7-10.md
        quests_starter.md
        quests_fame.md
        quests_other.md
      windurst/
        missions_rank1-3.md
        missions_rank4-6.md
        missions_rank7-10.md
        quests_starter.md
        quests_fame.md
        quests_other.md
      jeuno/
        quests.md
        limit_breaks.md
      zones/
        overworld.md
        dungeons.md
      nms/
        hnms.md
        field_nms.md
      bcnm.md
    02_zilart/
      missions_zm1-8.md
      missions_zm9-16.md
      sky_access.md
      sky_nms.md
      dynamis_original.md
    03_cop/
      missions_ch1-3.md
      missions_ch4-6.md
      missions_ch7-8.md
      tavnazia_zones.md
      sea_zones.md
      limbus.md
    04_toau/
      missions.md
      near_east_zones.md
      assault.md
      besieged.md
      salvage.md
      nyzul_isle.md
      einherjar.md
    05_wotg/
      missions.md
      campaign_zones.md
      campaign_battles.md
      campaign_ops.md
    06_abyssea/
      access.md
      visions.md
      scars.md
      heroes.md
      empyrean_armor.md
      empyrean_weapons.md
    07_soa/
      missions.md
      adoulin_zones.md
      ulbuka_zones.md
      colonization.md
      coalitions.md
      skirmish.md
      delve.md
      mog_garden.md
    08_rov/
      missions_ch1.md
      missions_ch2.md
      missions_ch3.md
      escha_zones.md
      rhapsody_kis.md
    09_endgame/
      ambuscade.md
      odyssey.md
      dynamis_divergence.md
      omen.md
      unity.md
      voidwatch.md
      domain_invasion.md
      geas_fete.md
      master_levels.md
      job_points.md
```

---

## Research Approach Per Batch

### Step 1: Pick topic from PROGRESS.md queue
### Step 2: Fetch bg-wiki page for that content
### Step 3: Scan codebase for implementation
### Step 4: Write findings to the MD file
### Step 5: Update PROGRESS.md (mark done, note blockers found)

Keep each batch to 15-30 minutes of work. Write what you found, even if incomplete. The next agent can pick up where you left off.

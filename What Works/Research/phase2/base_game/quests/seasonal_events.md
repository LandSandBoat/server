# Seasonal Events

## Source
- bg-wiki: https://www.bg-wiki.com/ffxi/Category:Events
- Codebase:
  - `scripts/events/handler.lua` -- seasonal event scheduler
  - `scripts/events/starlight_celebration.lua`
  - `scripts/events/egg_hunt_egg-stravaganza.lua`
  - `scripts/events/mog_bonanza.lua`
  - `scripts/events/login_campaign.lua` + `login_campaign_data.lua`
  - `scripts/globals/harvest_festivals.lua`
  - `scripts/globals/extravaganza.lua`
  - `scripts/globals/server.lua` -- calls checkSeasonalEvents on start/midnight
  - `settings/default/main.lua` -- event toggles (lines 256-292)

## Summary
The server has a proper seasonal event handler framework (`scripts/events/handler.lua`) that checks events on server start and at JST midnight. Six events have some level of implementation; four have no implementation at all. Of those implemented, only three are fully automated via the handler (Starlight, Egg Hunt, Mog Bonanza). Harvest Festival and Login Campaign require manual setting changes. Alter Ego Extravaganza is explicitly disabled due to missing client NPCs.

## Checklist

| Event | Status | Notes |
|-------|--------|-------|
| **Starlight Celebration** (Christmas) | WORKS | Auto-activates during December (JstMonth == 12). Spawns dynamic Christmas tree/decoration entities in all 3 nation cities (S.Sandy, N.Sandy, Bastok Mines/Markets/Port, Windurst Waters/Woods/Port). Changes Jeuno background music to starlight theme (music ID 239). Registered in seasonal handler. No NPC quests/rewards -- decorations and music only. |
| **Egg Hunt Egg-stravaganza** (Easter) | WORKS | Auto-activates Apr 6-17 by default (configurable in `settings/default/main.lua` EGG_HUNT block). Spawns dynamic Moogle NPCs and decorations in all 6 nation city zones. Full cutscene and reward system. Supports multiple eras (2005 base through 2019) with progressive reward unlocks. Era flags all default to `false` (2005 base era only). Registered in seasonal handler. |
| **Mog Bonanza** (lottery) | PARTIAL | Full framework exists and is registered in seasonal handler. Bonanza Moogle NPCs scripted in Port San d'Oria, Port Bastok, Port Windurst, and Chocobo Circuit. Supports pearl purchasing, number selection, winning number checking, and prize collection with 3 reward ranks. However: dates are hardcoded to 2023 (buying May 17 - Jun 15, collection Jul 11 - Jul 31), so **event is currently expired/inactive**. Requires updating `localSettings` dates in `scripts/events/mog_bonanza.lua` to activate. BONANZA_ID also needs updating for each run. |
| **Harvest Festival** (Halloween) | PARTIAL | Framework exists in `scripts/globals/harvest_festivals.lua`. Only 2005 edition implemented (2008-2010 commented out). NPCs in all 6 nation zones have halloween trade handlers. Gives costumes and halloween items (Pumpkin Head, Horror Head, Trick Staff, Treat Staff). Auto-activates Oct 20 - Nov 1 based on JST date. **Not** registered in the seasonal handler -- uses its own date check. Requires `HALLOWEEN_2005 = 1` in settings (default is 0 / disabled). Also supports `HALLOWEEN_YEAR_ROUND = 1` for testing. NPC costume skins applied via `HALLOWEEN_SKINS` tables in zone IDs files. |
| **Login Campaign** | PARTIAL | Full point-earning and prize-exchange system implemented. Greeter Moogles scripted in Port San d'Oria, Port Bastok, and Windurst Walls. Players earn 500 points first login, 100/day after. Prize shop with 8 price tiers (10-1500 points) including seals, ciphers, mounts, furniture, rings, and consumables. However: requires `ENABLE_LOGIN_CAMPAIGN = 1` in settings (default is 0). Dates hardcoded to Jun-Jul 2025 in `login_campaign.lua` -- **needs date update to activate**. Many prize items commented out (not yet available on server). |
| **Alter Ego Extravaganza** | MISSING | Framework exists in `scripts/globals/extravaganza.lua` with campaign types (SUMMER_NY, SPRING_FALL, BOTH). Shadow Era cipher vendors (Shixo, Shenni, Shuvo) are coded for WotG-era trust ciphers. **Explicitly disabled** -- `campaignActive()` hardcoded to return `NONE` with comment: "NPCs are currently not present in the client." Setting `ENABLE_TRUST_ALTER_EGO_EXTRAVAGANZA` exists (default 0) but is bypassed. Server message announcement system exists but is inert. |
| **Sunbreeze Festival** (summer) | MISSING | No scripts, no NPCs, no settings. Zero implementation. |
| **Valentione's Day** | MISSING | No scripts, no NPCs, no settings. Zero implementation. |
| **New Year's / Mandragora** | MISSING | No dedicated scripts. Only reference is Mog Bonanza's `SUMMER_NY` campaign type label. No Mandragora dream event, no Dream Hat system. |
| **Adventurer Appreciation Campaign** | MISSING | No scripts, no NPCs, no settings. Zero implementation. |

## Event Handler Architecture

The seasonal event system (`scripts/events/handler.lua`) provides:
- `SeasonalEvent` class with enable check, start function, and end function
- Checked on server start and JST midnight via `scripts/globals/server.lua`
- Three events registered: Starlight Celebration, Egg Hunt, Mog Bonanza
- Harvest Festival and Login Campaign are NOT registered in the handler (use their own mechanisms)

## Settings Reference (settings/default/main.lua)

| Setting | Default | Purpose |
|---------|---------|---------|
| `HALLOWEEN_2005` | 0 | Enable Harvest Festival 2005 edition |
| `HALLOWEEN_YEAR_ROUND` | 0 | Force Harvest Festival active outside Oct 20 - Nov 1 |
| `EGG_HUNT.START/FINISH` | Apr 6-17 | Egg Hunt date range |
| `EGG_HUNT.ERA_20xx` | all false | Enable progressive Egg Hunt reward eras |
| `ENABLE_LOGIN_CAMPAIGN` | 0 | Enable login point system |
| `ENABLE_TRUST_ALTER_EGO_EXTRAVAGANZA` | 0 | Alter Ego event (bypassed in code) |

## Blockers
- Mog Bonanza dates expired (2023) -- must be manually updated each time you want to run it
- Login Campaign dates set to Jun-Jul 2025 -- must be updated for current period
- Harvest Festival disabled by default (HALLOWEEN_2005 = 0)
- Login Campaign disabled by default (ENABLE_LOGIN_CAMPAIGN = 0)
- Alter Ego Extravaganza blocked at code level regardless of setting
- Sunbreeze, Valentione's, New Year's, Adventurer Appreciation have no implementation at all

## Fix Difficulty
- **Starlight Celebration**: N/A -- already works automatically in December
- **Egg Hunt**: Easy -- works automatically in April; enable later eras by setting flags to true
- **Mog Bonanza**: Easy -- update dates and BONANZA_ID in mog_bonanza.lua, update winning numbers
- **Harvest Festival**: Easy -- set `HALLOWEEN_2005 = 1` in settings; auto-activates in October
- **Login Campaign**: Easy -- set `ENABLE_LOGIN_CAMPAIGN = 1` and update dates in login_campaign.lua
- **Alter Ego Extravaganza**: Hard -- client-side NPCs reportedly removed; may need dynamic entity spawning like Starlight/Egg Hunt
- **Sunbreeze/Valentione's/New Year's/Appreciation**: Massive -- no implementation exists; would need full scripting from scratch

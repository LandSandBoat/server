-----------------------------------
-- Area: Lower Jeuno
--   NPC: Parike-Poranke
-- Type: Adventurer's Assistant
-- !pos -33.161 -1 -61.303 245
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    player:messageSpecial(ID.text.PARIKE_PORANKE_DIALOG)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

-----------------------------------
-- Area: Tavnazian Safehold
--   NPC: Travonce
-- Type: Standard NPC
-- !pos -89.068 -14.367 -0.030 26
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(210)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

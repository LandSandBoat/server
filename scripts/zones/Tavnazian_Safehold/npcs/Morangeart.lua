-----------------------------------
-- Area: Tavnazian Safehold
--   NPC: Morangeart
-- Type: ENM Quest Activator
-- !pos -74.308 -24.782 -28.475 26
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(520)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

-----------------------------------
-- Area: Port Jeuno
--   NPC: Dohhel
-- Type: Event Scene Replayer
-- !pos -156.031 -2 6.051 246
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(10028)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

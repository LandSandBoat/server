-----------------------------------
-- Area: Port Jeuno
--   NPC: Gatita
-- Type: Standard NPC
-- !pos -60.207 7.002 -59.143 246
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(44)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

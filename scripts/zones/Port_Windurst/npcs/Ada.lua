-----------------------------------
-- Area: Port Windurst
--   NPC: Ada
-- Type: Standard NPC
-- !pos -79.803 -6.75 168.652 240
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

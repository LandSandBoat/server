-----------------------------------
-- Area: Windurst Walls
--   NPC: Orudoba-Sondeba
-- Type: Standard NPC
-- !pos 70.086 -3.503 -69.939 239
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(43)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

-----------------------------------
-- Area: Windurst Walls
--   NPC: Tsuaora-Tsuora
-- Type: Standard NPC
-- !pos 71.489 -3.418 -67.809 239
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(42)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

-----------------------------------
-- Area: Port Windurst
--   NPC: Tonule
-- Type: Event Replayer
-- !pos -209.385 -9.117 195.217 240
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(551)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

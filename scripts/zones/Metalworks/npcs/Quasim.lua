-----------------------------------
-- Area: Metalworks
--  NPC: Quasim
-- Adventurer's Assistant
-------------------------------------
require("scripts/globals/settings")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(742)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

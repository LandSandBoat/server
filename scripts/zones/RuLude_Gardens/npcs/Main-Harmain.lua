-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Main-Harmain
-- Standard Info NPC
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(147)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

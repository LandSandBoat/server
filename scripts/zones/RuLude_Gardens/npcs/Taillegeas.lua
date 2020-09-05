-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Taillegeas
-- Standard Info NPC
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(10061)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

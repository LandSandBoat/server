-----------------------------------
-- Area: Windurst Walls
--  NPC: Ran
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (math.random() >= .5) then
        player:startEvent(272)
    else
        player:startEvent(273)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

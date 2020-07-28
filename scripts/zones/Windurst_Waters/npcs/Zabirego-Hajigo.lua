-----------------------------------
-- Area: Windurst Waters
--  NPC: Zabirego-Hajigo
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

fame = player:getFameLevel(2)

    if (fame == 9) then
        player:startEvent(784)
    else
        player:startEvent(687 + fame)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end

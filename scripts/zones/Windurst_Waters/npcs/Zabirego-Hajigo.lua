-----------------------------------
-- Area: Windurst Waters
--  NPC: Zabirego-Hajigo
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

fame = player:getFameLevel(2)

    if (fame == 9) then
        player:startEvent(784)
    else
        player:startEvent(687 + fame)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

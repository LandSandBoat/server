-----------------------------------
-- Area: Kazham
--  NPC: Dakha Topsalwan
-- !zone 250
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    Z = player:getZPos()

    if (Z >= -20 and Z <= -16) then
        player:startEvent(66)
    else
        player:startEvent(121)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

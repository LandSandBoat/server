-----------------------------------
-- Area: Arrapago Reef
-- Door: Heavy Iron Gate
-- !pos 5 -9 579 54
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getXPos() < 8) then
        player:startEvent(106)
    else
        player:startEvent(107)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

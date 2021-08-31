-----------------------------------
-- Area: Mount Zhayolm
-- Door: Heavy Iron Gate
-- !pos 660 -27 328 61
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getZPos() < 332 then
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

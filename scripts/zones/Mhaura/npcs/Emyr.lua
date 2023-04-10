-----------------------------------
-- Area: Mhaura
--  NPC: Emyr
-- !pos 45.021 -9 37.095 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getZPos() >= 39 then
        player:startEvent(228)
    else
        player:startEvent(223)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

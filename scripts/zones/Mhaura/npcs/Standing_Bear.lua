-----------------------------------
-- Area: Mhaura
--  NPC: Standing Bear
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getZPos() > 38.5 then
        player:startEvent(14)
    else
        player:startEvent(235)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

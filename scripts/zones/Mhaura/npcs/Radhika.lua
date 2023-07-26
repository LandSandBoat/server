-----------------------------------
-- Area: Mhaura
--  NPC: Radhika
-- !pos 34.124 -8.999 39.629 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getZPos() >= 39 then
        player:startEvent(229)
    else
        player:startEvent(222)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity

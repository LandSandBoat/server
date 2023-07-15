-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Door : Wooden Shutter
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(5)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if option == 1 then
        player:setPos(-480, -5.65, 669, 70, 2)
    end
end

return entity

-----------------------------------
-- Area: Kazham
--  NPC: Vah Keshura
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('BathedInScent') == 1 then
        player:startEvent(187) -- scent from Blue Rafflesias
    else
        player:startEvent(124)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity

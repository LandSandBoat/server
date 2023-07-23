-----------------------------------
-- Area: Mhaura
--  NPC: Felisa
-- Admits players to the dock in Mhaura.
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getZPos() > 38.5 then
        player:startEvent(221, player:getGil(), 100)
    else
        player:startEvent(235)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 221 and option == 333 then
        player:delGil(100)
    end
end

return entity

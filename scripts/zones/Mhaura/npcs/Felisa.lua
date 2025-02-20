-----------------------------------
-- Area: Mhaura
--  NPC: Felisa
-- Admits players to the dock in Mhaura.
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() > 38.5 then
        player:startEvent(221, player:getGil(), 100)
    else
        player:startEvent(235)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 221 and option == 333 then
        player:delGil(100)
    end
end

return entity

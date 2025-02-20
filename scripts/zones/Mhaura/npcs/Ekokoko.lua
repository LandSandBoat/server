-----------------------------------
-- Area: Mhaura
--  NPC: Ekokoko
-- Gouvernor of Mhaura
-- Involved in Quest: Riding on the Clouds
-- !pos -78 -24 28 249
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasCompletedUniqueEvent(xi.uniqueEvent.EKOKOKO_INTRODUCTION) then
        player:startEvent(51)
    else
        player:startEvent(52)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 51 then
        player:setUniqueEvent(xi.uniqueEvent.EKOKOKO_INTRODUCTION)
    end
end

return entity

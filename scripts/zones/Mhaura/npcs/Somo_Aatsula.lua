-----------------------------------
-- Area: Mhaura
-- NPC: Somo Aatsula
-- !pos 3.649 -4.000 104.244
-- Shared unique event with Mauh Halaapah
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasCompletedUniqueEvent(xi.uniqueEvent.MHAURA_INTRODUCTION) then
        player:startEvent(35)
    else
        player:startEvent(36)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 35 then
        player:setUniqueEvent(xi.uniqueEvent.MHAURA_INTRODUCTION)
    end
end

return entity

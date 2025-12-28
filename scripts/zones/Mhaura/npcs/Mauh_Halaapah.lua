-----------------------------------
-- Area: Mhaura
-- NPC: Mauh Halaapah
-- !pos 30.003 -8.000 49.514
-- Shared unique event with Somo Aatsula
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasCompletedUniqueEvent(xi.uniqueEvent.MHAURA_INTRODUCTION) then
        player:startEvent(40)
    else
        player:startEvent(41)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 40 then
        player:setUniqueEvent(xi.uniqueEvent.MHAURA_INTRODUCTION)
    end
end

return entity

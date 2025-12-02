-----------------------------------
-- Area: Mhaura
-- NPC: Hyria
-- !pos -65.998 -24.000 34.070
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasCompletedUniqueEvent(xi.uniqueEvent.HYRIA_INTRODUCTION) then
        player:startEvent(20)
    else
        player:startEvent(21)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 20 then
        player:setUniqueEvent(xi.uniqueEvent.HYRIA_INTRODUCTION)
    end
end

return entity

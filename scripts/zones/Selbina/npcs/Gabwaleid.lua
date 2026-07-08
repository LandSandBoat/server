-----------------------------------
-- Area: Selbina
-- NPC: Gabwaleid
-- !pos -17.381 -7.338 9.126
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasCompletedUniqueEvent(xi.uniqueEvent.GABWALEID_INTRODUCTION) then
        player:startEvent(600)
    else
        player:startEvent(601)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 600 then
        player:setUniqueEvent(xi.uniqueEvent.GABWALEID_INTRODUCTION)
    end
end

return entity

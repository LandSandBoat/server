-----------------------------------
-- Area: Selbina
-- NPC: Flandiace
-- !pos 20.039 -14.559 85.623
-- Unique event shared with Velema
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasCompletedUniqueEvent(xi.uniqueEvent.SELBINA_INTRODUCTION) then
        player:startEvent(12)
    else
        player:startEvent(13)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 12 then
        player:setUniqueEvent(xi.uniqueEvent.SELBINA_INTRODUCTION)
    end
end

return entity

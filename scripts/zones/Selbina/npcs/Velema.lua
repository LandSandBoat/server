-----------------------------------
-- Area: Selbina
-- NPC: Velema
-- !pos 28.321 -2.86 -14.610
-- Unique event shared with Flandiace
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasCompletedUniqueEvent(xi.uniqueEvent.SELBINA_INTRODUCTION) then
        player:startEvent(10)
    else
        player:startEvent(11)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 12 then
        player:setUniqueEvent(xi.uniqueEvent.SELBINA_INTRODUCTION)
    end
end

return entity

-----------------------------------
-- Area: Bibiki Bay
--  NPC: Clamming Point
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.clamming.nodeOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.clamming.nodeOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.clamming.nodeOnEventFinish(player, csid, option, npc)
end

return entity

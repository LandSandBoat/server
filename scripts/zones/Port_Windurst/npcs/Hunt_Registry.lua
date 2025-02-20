-----------------------------------
-- Area: Port Windurst
--  NPC: Hunt Registry
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.hunts.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.hunts.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.hunts.onEventFinish(player, csid, option, npc)
end

return entity

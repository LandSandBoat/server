-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Rytaal
-- !pos 112.002 -1.338 -45.038 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.assault.onRytaalTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.onRytaalEventFinish(player, csid, option, npc)
end

return entity

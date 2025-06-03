-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Asrahd
-- Type: Imperial Gate Guard
-- !pos 0.011 -1 10.587 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.besieged.onTrigger(player, npc, 630)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.besieged.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.besieged.onEventFinish(player, csid, option, npc)
end

return entity

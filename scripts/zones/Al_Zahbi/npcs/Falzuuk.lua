-----------------------------------
-- Area: Al Zahbi
--  NPC: Falzuuk
-- Type: Imperial Gate Guard
-- !pos -60.486 0.999 105.397 48
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.besieged.onTrigger(player, npc, 216)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.besieged.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.besieged.onEventFinish(player, csid, option, npc)
end

return entity

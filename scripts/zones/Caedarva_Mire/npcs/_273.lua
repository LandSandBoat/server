-----------------------------------
-- Area: Caedarva Mire
-- Door: Runic Seal
-- !pos -353 -3 -20 79
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.assault.onRunicTrigger(player, npc, xi.zone.PERIQIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.assault.onAssaultUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.onEventFinish(player, csid, option, npc)
end

return entity

-----------------------------------
-- Area: Mount Zhayolm
-- Door: Runic Seal
-- !pos 703 -18 382 61
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.assault.onRunicTrigger(player, npc, xi.zone.LEBROS_CAVERN)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.assault.onAssaultUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.onEventFinish(player, csid, option, npc)
end

return entity

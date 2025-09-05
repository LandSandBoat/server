-----------------------------------
-- Area: Arrapago Reef
-- Door: Runic Seal
-- !pos 36 -10 620 54
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.assault.onRunicTrigger(player, npc, xi.zone.ILRUSI_ATOLL)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.assault.onAssaultUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.onEventFinish(player, csid, option)
end

return entity

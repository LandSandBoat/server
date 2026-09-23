-----------------------------------
-- Area: Bhaflau Thickets
-- Door: Runic Seal
-- !pos -180 -6.8 -833 52
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.assault.onRunicTrigger(player, npc, xi.zone.MAMOOL_JA_TRAINING_GROUNDS)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.assault.onAssaultUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.onEventFinish(player, csid, option, npc)
end

return entity

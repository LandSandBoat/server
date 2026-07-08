-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Isdebaaq
-- Type: Assault Mission Giver
-- !pos 127.565 0.161 -43.846 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.assault.onMissionGiverTrigger(player, npc, 274, xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.assault.onMissionGiverUpdate(player, csid, option, npc, 274, xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.onMissionGiverEventFinish(player, csid, option, npc, 274, xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS)
end

return entity

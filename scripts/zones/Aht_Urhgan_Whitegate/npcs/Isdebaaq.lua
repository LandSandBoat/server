-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Isdebaaq
-- Type: Assault Mission Giver
-- !pos 127.565 0.161 -43.846 50
-----------------------------------
---@type TNpcEntity
local entity = {}

local assaultArea = xi.assault.assaultArea.MAMOOL_JA_TRAINING_GROUNDS
local eventOffset = 274

entity.onTrigger = function(player, npc)
    xi.assault.onMissionGiverTrigger(player, npc, eventOffset, assaultArea)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.assault.onMissionGiverUpdate(player, csid, option, npc, assaultArea)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.assault.onMissionGiverEventFinish(player, csid, option, npc, eventOffset, assaultArea)
end

return entity

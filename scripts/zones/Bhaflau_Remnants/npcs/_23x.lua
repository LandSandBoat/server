-----------------------------------
-- NPC: Door
-- Area: Bhaflau Remnants
-- 5th Floor Door to Boss
-- !pos -340 -4 400
-----------------------------------
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.salvage.openBossDoor(npc)
end

return entity

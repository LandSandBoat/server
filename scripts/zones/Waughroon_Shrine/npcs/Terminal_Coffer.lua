-----------------------------------
-- Area: Waughroon Shrine
--  NPC: Terminal Coffer
-- A.M.A.N. Trove
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.amanTrove.onCofferTrigger(player, npc)
end

return entity

-----------------------------------
-- Area: Port San d'Oria
--  NPC: Thierride
-- Type: Quest Giver
-- !pos -67 -5 -28 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    player:startEvent(529)
end

return entity

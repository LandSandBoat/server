-----------------------------------
-- Area: Kazham
--  NPC: Ney Hiparujah
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(251 + player:getFameLevel(xi.fameArea.WINDURST))
end

return entity

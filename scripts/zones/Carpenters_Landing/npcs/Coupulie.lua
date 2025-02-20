-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Coupulie
-- !pos -313.585 -3.628 490.944 2
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(32, 618, 652, 50, 300)
end

return entity

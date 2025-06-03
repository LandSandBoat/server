-----------------------------------
-- Area: Windurst Woods
--  NPC: Forine
-- Involved In Mission: Journey Abroad
-- !pos -52.677 -0.501 -26.299 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getNation() == xi.nation.SANDORIA then
        player:startEvent(446)
    else
        player:startEvent(445)
    end
end

return entity

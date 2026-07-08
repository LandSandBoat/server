-----------------------------------
-- Area: Windurst Woods
--  NPC: Erpolant
-- !pos -63.224 -0.749 -33.424 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getNation() == xi.nation.SANDORIA then
        player:startEvent(447)
    else
        player:startEvent(444)
    end
end

return entity

-----------------------------------
-- Area: Heaven's Tower
--  NPC: Jatata
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getNation() == xi.nation.WINDURST then
        player:startEvent(77)
    else
        player:startEvent(78)
    end
end

return entity

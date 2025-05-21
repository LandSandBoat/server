-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Commojourt
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local rand = math.random(1, 2)

    if rand == 1 then
        player:startEvent(653)
    else
        player:startEvent(657)
    end
end

return entity

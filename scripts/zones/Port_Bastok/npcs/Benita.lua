-----------------------------------
-- Area: Port Bastok
--  NPC: Benita
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local rand = math.random(1, 2)

    -- TODO: Needs verification
    if rand == 1 then
        player:startEvent(102)
    else
        player:startEvent(103)
    end
end

return entity

-----------------------------------
-- Area: Windurst Waters
--  NPC: Zabirego-Hajigo
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local fame = player:getFameLevel(xi.fameArea.WINDURST)
    if fame == 9 then
        player:startEvent(784)
    else
        player:startEvent(687 + fame)
    end
end

return entity

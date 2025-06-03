-----------------------------------
-- Area: Windurst Waters
--  NPC: Zabirego-Hajigo
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local fame = player:getFameLevel(2)
    if fame == 9 then
        player:startEvent(784)
    else
        player:startEvent(687 + fame)
    end
end

return entity

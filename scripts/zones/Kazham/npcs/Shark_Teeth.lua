-----------------------------------
-- Area: Kazham
--  NPC: Dakha Topsalwan
-- !zone 250
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local zPos = player:getZPos()

    if zPos >= -20 and zPos <= -16 then
        player:startEvent(120) -- On the Dock
    else
        player:startEvent(119) -- Inside of Kazham
    end
end

return entity

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
        player:startEvent(66)
    else
        player:startEvent(121)
    end
end

return entity

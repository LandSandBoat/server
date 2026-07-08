-----------------------------------
-- Area: Kazham
--  NPC: Bhoyu Halpatacco
-- !pos -18 -4 -15 250
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local zPos = player:getZPos()

    if zPos >= -11 and zPos <= -6 then
        player:startEvent(117) -- Inside of the Dock
    else
        player:startEvent(118) -- Inside of Kazham
    end
end

return entity

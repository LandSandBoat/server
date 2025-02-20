-----------------------------------
-- Area: Mhaura
--  NPC: Emyr
-- !pos 45.021 -9 37.095 249
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() >= 39 then
        player:startEvent(228)
    else
        player:startEvent(223)
    end
end

return entity

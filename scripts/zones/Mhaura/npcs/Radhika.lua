-----------------------------------
-- Area: Mhaura
--  NPC: Radhika
-- !pos 34.124 -8.999 39.629 249
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() >= 39 then
        player:startEvent(229)
    else
        player:startEvent(222)
    end
end

return entity

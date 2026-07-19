-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Nuria
-- Type: Merry Map Marker
-- !pos 43.030 9.999 -66.539 243
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.MAP_OF_THE_JEUNO_AREA) then
        player:startEvent(10095)
    else
        player:startEvent(10096)
    end
end

return entity

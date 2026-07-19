-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Rumoie
-- Type: Merry Map Marker
-- !pos 149.696 -2.000 151.631 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.MAP_OF_THE_SAN_DORIA_AREA) then
        player:startEvent(863)
    else
        player:startEvent(864)
    end
end

return entity

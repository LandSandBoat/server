-----------------------------------
-- Area: Port Bastok
--  NPC: Gwinar
-- Type: Merry Map Marker
-- !pos 38.349 8.499 -230.827 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.MAP_OF_THE_BASTOK_AREA) then
        player:startEvent(365)
    else
        player:startEvent(366)
    end
end

return entity

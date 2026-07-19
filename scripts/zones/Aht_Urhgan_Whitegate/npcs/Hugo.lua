-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Hugo
-- Type: Merry Map Marker
-- !pos -81.001 0.000 -68.500 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.MAP_OF_AL_ZAHBI) then
        player:startEvent(5065, { text_table = 0 })
    else
        player:startEvent(5066, { text_table = 0 })
    end
end

return entity

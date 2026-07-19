-----------------------------------
-- Area: Windurst Waters
--  NPC: Zelala
-- Type: Merry Map Marker
-- !pos 169.855 -0.295 -3.238 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.MAP_OF_THE_WINDURST_AREA) then
        player:startEvent(960)
    else
        player:startEvent(961)
    end
end

return entity

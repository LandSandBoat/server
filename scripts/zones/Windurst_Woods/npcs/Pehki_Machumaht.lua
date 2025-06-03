-----------------------------------
-- Area: Windurst Woods
--  NPC: Pehki Machumaht
-- Map Seller NPC
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.maps.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.maps.onEventUpdate(player, csid, option, npc)
end

return entity

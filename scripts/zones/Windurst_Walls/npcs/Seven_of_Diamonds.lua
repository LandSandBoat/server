-----------------------------------
-- Area: Windurst Walls
--  NPC: Seven of Diamonds
-- !pos 6.612 -3.5 278.553 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.RHINOSTERY_CERTIFICATE) then
        player:startEvent(390)
    else
        player:startEvent(264)
    end
end

return entity

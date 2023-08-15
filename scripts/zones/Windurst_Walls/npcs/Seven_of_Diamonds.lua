-----------------------------------
-- Area: Windurst Walls
--  NPC: Seven of Diamonds
-- !pos 6.612 -3.5 278.553 239
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.RHINOSTERY_CERTIFICATE) then
        player:startEvent(390)
    else
        player:startEvent(264)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity

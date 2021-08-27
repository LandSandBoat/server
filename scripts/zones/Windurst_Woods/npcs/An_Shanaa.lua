-----------------------------------
-- Area: Windurst Woods
--  NPC: An Shanaa
-- Working 100%
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.A_SONG_OF_LOVE) then
        player:startEvent(408, 0, xi.ki.A_SONG_OF_LOVE)
    elseif player:getCharVar("CHASING_TALES_TRACK_BOOK") >= 1 then
        player:startEvent(405) -- Neeed CS here
    else
        player:startEvent(45)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

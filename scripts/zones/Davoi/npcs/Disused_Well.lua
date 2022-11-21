-----------------------------------
-- Area: Davoi
--  NPC: Disused Well
-- Involved in Quest: A Knight's Test
-- !pos -221 2 -293 149
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Davoi/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        not player:hasKeyItem(xi.ki.KNIGHTS_SOUL) and
        player:hasKeyItem(xi.ki.BOOK_OF_TASKS) and
        player:hasKeyItem(xi.ki.BOOK_OF_THE_WEST) and
        player:hasKeyItem(xi.ki.BOOK_OF_THE_EAST)
    then
        player:addKeyItem(xi.ki.KNIGHTS_SOUL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.KNIGHTS_SOUL)
    else
        player:messageSpecial(ID.text.A_WELL)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity

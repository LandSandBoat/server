-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm6 (???)
-- Involved in Quest: Hitting the Marquisate (THF AF3)
-- !pos -220.039 -5.500 194.192 200
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.BOMB_INCENSE) and player:getCharVar("hittingTheMarquisateHagainCS") == 2 then
        player:messageSpecial(ID.text.PRESENCE_FROM_CEILING)
        player:startEvent(50, xi.keyItem.BOMB_INCENSE)
    else
        player:messageSpecial(ID.text.HOLE_IN_THE_CEILING) -- Default
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 50 and option == 1 then
        player:messageSpecial(ID.text.THE_PRESENCE_MOVES + 1) -- Presence moved west.
        player:setCharVar("hittingTheMarquisateHagainCS", 3)
    end
end

return entity
